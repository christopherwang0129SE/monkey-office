/*
 * Tys-aben — Office Noise Reactor Firmware (V1.0)
 * =================================================================
 * Arduino-ESP32 sketch for the wall-mounted "shush monkey".
 *
 * Hardware (configurable below):
 *   - ESP32-class MCU (S3, C3, or original — adjust I2S pins)
 *   - I2S MEMS microphone (INMP441 / SPH0645 / similar)
 *   - SG90 micro servo (or compatible 5V hobby servo)
 *
 * What it does:
 *   1. Continuously samples ambient sound via I2S mic.
 *   2. Computes a smoothed RMS / dB-ish value.
 *   3. When sustained noise crosses THRESHOLD for DWELL_MS,
 *      drives the servo through a cosine-eased motion profile
 *      to raise the monkey's arms and cover its mouth.
 *   4. Holds while noise stays above (threshold − 6 dB hysteresis),
 *      minimum HOLD_MS, then eases back to rest.
 *   5. Cooldown COOLDOWN_MS between triggers — the monkey is a
 *      gentle social signal, not a meter.
 *
 * Build: open in Arduino IDE with ESP32 board package installed.
 * Select your specific ESP32 board, configure pins below, upload.
 */

#include <Arduino.h>
#include <driver/i2s.h>

// =====================================================================
//  CONFIGURATION — adjust to your board
// =====================================================================

// I2S microphone pins (INMP441 / SPH0645)
#define I2S_SCK     14   // bit clock (BCLK)
#define I2S_WS      15   // word select / LR clock (LRCL)
#define I2S_SD      32   // serial data (DOUT)
#define I2S_PORT    I2S_NUM_0

// Servo control
#define SERVO_PIN          18
#define SERVO_PWM_CHANNEL  0
#define SERVO_PWM_FREQ     50      // 50 Hz standard hobby servo
#define SERVO_PWM_BITS     14      // 14-bit resolution → fine-grained motion
// SG90 pulse range: 500 µs (0°) to 2500 µs (180°), neutral 1500 µs.
// With 50 Hz period = 20 ms = 2^14 ticks ≈ 16384 ticks per 20 ms.
// 1 µs ≈ 0.82 ticks.
#define SERVO_REST_US     1000     // arms hanging at rest
#define SERVO_PEAK_US     1900     // arms cupping mouth (tune empirically)
#define SERVO_MIN_US       500
#define SERVO_MAX_US      2500

// Noise detection tuning
#define SAMPLE_RATE         16000   // Hz
#define SAMPLE_BLOCK_SIZE   512     // samples per RMS window
#define THRESHOLD_DB        65.0    // trigger above this (rough dB-ish)
#define HYSTERESIS_DB        6.0    // release threshold = THRESHOLD - HYSTERESIS
#define DWELL_MS            800     // sustained above-threshold required
#define HOLD_MS            4000     // minimum hold at peak
#define COOLDOWN_MS        8000     // minimum interval between triggers

// Motion timing (cosine-eased, never linear)
#define RAISE_MS           1200     // arms rising — gentle ascent
#define LOWER_MS           1800     // arms returning — slower, reluctant
#define MOTION_TICK_MS       20     // motion-loop update interval

// =====================================================================
//  STATE
// =====================================================================

enum State {
  S_IDLE,
  S_DWELL,        // noise above threshold, waiting to confirm sustained
  S_RAISING,      // mid-arc, arms rising
  S_HOLDING,      // arms cupping mouth, holding
  S_LOWERING,     // arms releasing
  S_COOLDOWN      // post-trigger lockout
};

State state = S_IDLE;
unsigned long state_start_ms = 0;
unsigned long last_above_threshold_ms = 0;
float current_servo_us = SERVO_REST_US;
float motion_start_us = SERVO_REST_US;
float motion_target_us = SERVO_REST_US;

// =====================================================================
//  I2S MIC INIT + READ
// =====================================================================

void i2s_init() {
  i2s_config_t cfg = {
    .mode                 = (i2s_mode_t)(I2S_MODE_MASTER | I2S_MODE_RX),
    .sample_rate          = SAMPLE_RATE,
    .bits_per_sample      = I2S_BITS_PER_SAMPLE_32BIT,
    .channel_format       = I2S_CHANNEL_FMT_ONLY_LEFT,
    .communication_format = I2S_COMM_FORMAT_STAND_I2S,
    .intr_alloc_flags     = ESP_INTR_FLAG_LEVEL1,
    .dma_buf_count        = 4,
    .dma_buf_len          = SAMPLE_BLOCK_SIZE,
    .use_apll             = false,
    .tx_desc_auto_clear   = false,
    .fixed_mclk           = 0
  };
  i2s_pin_config_t pins = {
    .bck_io_num   = I2S_SCK,
    .ws_io_num    = I2S_WS,
    .data_out_num = I2S_PIN_NO_CHANGE,
    .data_in_num  = I2S_SD
  };
  i2s_driver_install(I2S_PORT, &cfg, 0, NULL);
  i2s_set_pin(I2S_PORT, &pins);
  i2s_set_clk(I2S_PORT, SAMPLE_RATE, I2S_BITS_PER_SAMPLE_32BIT, I2S_CHANNEL_MONO);
}

// Read a block of samples, return dB-ish value (rough — not calibrated SPL).
float read_db_ish() {
  static int32_t samples[SAMPLE_BLOCK_SIZE];
  size_t bytes_read = 0;
  i2s_read(I2S_PORT, samples, sizeof(samples), &bytes_read, portMAX_DELAY);
  int n = bytes_read / 4;
  if (n == 0) return -100.0;

  // Sum of squares
  double sumsq = 0.0;
  for (int i = 0; i < n; ++i) {
    // INMP441 outputs 24-bit data left-aligned in 32-bit word
    int32_t s = samples[i] >> 14;   // bring down to manageable range
    sumsq += (double)s * (double)s;
  }
  double rms = sqrt(sumsq / n);
  // Rough dB conversion — calibrate with known reference for absolute SPL.
  // Reference 1.0 = noise floor; log10 scale.
  if (rms < 1.0) rms = 1.0;
  return 20.0 * log10(rms);
}

// =====================================================================
//  SERVO
// =====================================================================

void servo_init() {
  ledcSetup(SERVO_PWM_CHANNEL, SERVO_PWM_FREQ, SERVO_PWM_BITS);
  ledcAttachPin(SERVO_PIN, SERVO_PWM_CHANNEL);
  servo_write_us(SERVO_REST_US);
}

void servo_write_us(float us) {
  us = constrain(us, (float)SERVO_MIN_US, (float)SERVO_MAX_US);
  // duty (in PWM ticks) = us / period_us * 2^bits
  // period = 1e6/50 = 20000 µs; 2^14 = 16384
  uint32_t duty = (uint32_t)(us * 16384.0 / 20000.0);
  ledcWrite(SERVO_PWM_CHANNEL, duty);
}

// Cosine ease in/out — 0..1 maps to 0..1, but with smooth ends.
float cosine_ease(float t) {
  if (t <= 0.0) return 0.0;
  if (t >= 1.0) return 1.0;
  return 0.5 - 0.5 * cosf(PI * t);
}

void update_motion(float duration_ms) {
  unsigned long now = millis();
  float t = (float)(now - state_start_ms) / duration_ms;
  if (t >= 1.0) t = 1.0;
  float eased = cosine_ease(t);
  current_servo_us = motion_start_us + (motion_target_us - motion_start_us) * eased;
  servo_write_us(current_servo_us);
}

void start_motion(float to_us, float duration_ms) {
  motion_start_us = current_servo_us;
  motion_target_us = to_us;
  state_start_ms = millis();
}

// =====================================================================
//  STATE MACHINE
// =====================================================================

void enter_state(State new_state) {
  state = new_state;
  state_start_ms = millis();
}

void loop_state_machine(float db_now) {
  unsigned long now = millis();
  bool above = (db_now > THRESHOLD_DB);
  bool above_release = (db_now > (THRESHOLD_DB - HYSTERESIS_DB));
  if (above) last_above_threshold_ms = now;

  switch (state) {
    case S_IDLE:
      if (above) enter_state(S_DWELL);
      break;

    case S_DWELL:
      if (!above) { enter_state(S_IDLE); break; }
      if (now - state_start_ms >= DWELL_MS) {
        // Triggered — begin raising arms
        start_motion(SERVO_PEAK_US, RAISE_MS);
        enter_state(S_RAISING);
      }
      break;

    case S_RAISING:
      update_motion(RAISE_MS);
      if (now - state_start_ms >= RAISE_MS) {
        enter_state(S_HOLDING);
      }
      break;

    case S_HOLDING: {
      // Maintain servo at peak
      servo_write_us(SERVO_PEAK_US);
      bool min_hold_met = (now - state_start_ms >= HOLD_MS);
      bool noise_gone = (now - last_above_threshold_ms > 500);
      if (min_hold_met && noise_gone && !above_release) {
        start_motion(SERVO_REST_US, LOWER_MS);
        enter_state(S_LOWERING);
      }
      break;
    }

    case S_LOWERING:
      update_motion(LOWER_MS);
      if (now - state_start_ms >= LOWER_MS) {
        enter_state(S_COOLDOWN);
      }
      break;

    case S_COOLDOWN:
      servo_write_us(SERVO_REST_US);
      if (now - state_start_ms >= COOLDOWN_MS) {
        enter_state(S_IDLE);
      }
      break;
  }
}

// =====================================================================
//  ARDUINO ENTRY POINTS
// =====================================================================

void setup() {
  Serial.begin(115200);
  delay(200);
  Serial.println("Tys-aben firmware booting…");
  i2s_init();
  servo_init();
  Serial.println("Ready. Listening for noise events.");
}

void loop() {
  float db = read_db_ish();

  // Debug stream — comment out for production
  static unsigned long last_print = 0;
  if (millis() - last_print > 200) {
    Serial.printf("dB: %5.1f  state: %d\n", db, (int)state);
    last_print = millis();
  }

  loop_state_machine(db);
  delay(MOTION_TICK_MS);
}
