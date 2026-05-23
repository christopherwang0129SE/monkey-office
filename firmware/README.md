# Firmware — Tys-aben V1.0

> Arduino-ESP32 sketch that drives the noise-detection → arm-motion loop.

## File

- [`tys-aben/tys-aben.ino`](tys-aben/tys-aben.ino) — single-file sketch, ~200 lines.
- **Compile-tested ✓** with arduino-cli + ESP32 Arduino core 3.3.8 (`esp32:esp32:esp32c3`). Program 312 KB (24% of 1.3 MB flash), RAM 15 KB (4% of 320 KB).

## Hardware connections

| Pin | Connects to | Notes |
|---|---|---|
| `I2S_SCK = 14` | Mic BCLK | I2S bit clock |
| `I2S_WS = 15` | Mic LRCL / WS | I2S word select |
| `I2S_SD = 32` | Mic DOUT | I2S serial data in |
| `SERVO_PIN = 18` | SG90 signal wire (orange) | PWM-driven |
| 5V | Mic VCC + servo V+ | both run on 5V |
| GND | Mic GND + servo GND | common ground |

Adjust pins at the top of `tys-aben.ino` to match your specific
ESP32 board variant.

## Build & upload

1. Install [Arduino IDE](https://www.arduino.cc/en/software).
2. Add ESP32 board support: File → Preferences → Additional Boards
   Manager URLs → add `https://espressif.github.io/arduino-esp32/package_esp32_index.json`
3. Tools → Board → ESP32 Arduino → select your specific board.
4. Open [`tys-aben/tys-aben.ino`](tys-aben/tys-aben.ino).
5. Adjust pins + tuning constants if needed.
6. Tools → Port → select your USB-C-connected board.
7. Upload (arrow icon in toolbar).
8. Tools → Serial Monitor → 115200 baud. Watch the dB readings.

## First-run tuning

The default `THRESHOLD_DB = 65.0` is a rough starting point and is
**not calibrated SPL**. The mic outputs raw I2S samples that get
log-converted to a dB-ish number — useful for relative comparison
but not absolute room SPL.

To tune:
1. Open Serial Monitor at 115200 baud.
2. Sit in a quiet room → note the baseline number (e.g. 35).
3. Have a normal conversation 1 m from the mic → note the value
   (e.g. 55).
4. Have someone speak loudly / two people in conversation →
   note the value (e.g. 70).
5. Set `THRESHOLD_DB` to ~5 above your "loud" baseline.
6. Re-upload.

## Tuning the servo positions

`SERVO_REST_US` and `SERVO_PEAK_US` determine where the arms sit at
rest and at peak. Defaults:
```
SERVO_REST_US = 1000   // arms hanging at rest
SERVO_PEAK_US = 1900   // arms cupping mouth
```

After physical assembly with tendons attached, you'll almost
certainly need to adjust these. Procedure:
1. With the monkey assembled but no power, manually verify the
   arms hang at rest with the servo horn pointing in the "0°"
   direction (5° forward of vertical).
2. Power on. Edit `SERVO_REST_US` until the arms sit naturally at
   rest with no tendon tension.
3. Force the trigger (clap loudly or temporarily set `THRESHOLD_DB
   = 30`) and watch the arms go to peak.
4. Edit `SERVO_PEAK_US` until the hands cup the mouth precisely.
5. Optional: set both arms' return-elastic tension to match so they
   hang symmetrically at rest.

## What firmware doesn't do (yet — V1.x candidates)

- WiFi configuration UI (currently constants in code)
- Calibrated SPL reading (requires reference mic + calibration step)
- Voice activity detection (currently any loud noise triggers)
- LED status indication (no LEDs in V1 hardware)
- OTA firmware updates
- dB logging / metrics dashboard

These are all explicitly out of scope for V1 — see
[`../product/plan.md`](../product/plan.md).
