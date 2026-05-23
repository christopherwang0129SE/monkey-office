# Monkey — Office Noise Reactor

> 3D-printed monkey that listens to the room and reacts when the office gets too loud.

---

## 1. Concept (one paragraph)

A small, 3D-printed monkey sits on a desk or shelf in an open office. It contains an ESP32 with a microphone that continuously measures ambient sound level. When the noise crosses a threshold (e.g. sustained chatter, a loud meeting bleeding into the open floor), the monkey reacts in a way that gently signals "it's too loud in here" — without anyone having to be the person who shushes the room.

The reaction itself is intentionally left open in this plan (see §5) — we want the dev taking this over to weigh in on what's feasible, cheap, and not annoying after the 50th trigger.

---

## 2. Scope — what V1 must do

**Must:**
- Detect ambient noise level via onboard microphone.
- Trigger a reaction when noise exceeds a configurable threshold for a configurable duration (avoid reacting to single claps / door slams).
- Be self-contained inside a 3D-printed monkey enclosure.
- Run from USB-C power (no battery in V1).

**Nice-to-have (V1.x):**
- WiFi connectivity for remote config / threshold tuning.
- Simple web UI or app to see current dB level + adjust sensitivity.
- Voice input (see §6).

**Out of scope for V1:**
- Battery / portable operation.
- Multiple monkeys talking to each other.
- Cloud dashboard, analytics.

---

## 3. Hardware bill of materials

| Part | Notes | Approx cost |
|---|---|---|
| ESP32 dev board (ESP32-S3 recommended) | Built-in WiFi/BT, I2S mic support, USB-C | ~$5–10 |
| I2S MEMS microphone (e.g. INMP441 or SPH0645) | Digital mic, cleaner than analog for noise-level work | ~$3 |
| Reaction output (TBD — see §5) | Speaker / LEDs / micro-servo | $2–10 |
| 3D-printed enclosure | PLA, designed around chosen components | filament cost only |
| USB-C cable + 5V power supply | | ~$5 |

**Total target BOM: under $25.**

---

## 4. Software stack (proposed)

- **Firmware:** Arduino-ESP32 framework (C++) or ESP-IDF. Avoid MicroPython for V1 — audio sampling timing is easier in C.
- **Audio sampling:** I2S DMA → compute short-window RMS → smoothed dB-ish value.
- **Trigger logic:** threshold + dwell time (e.g. "above X for Y seconds") + cooldown (don't re-trigger for Z seconds after a reaction).
- **Config:** hard-coded constants in V1; WiFi-served config page in V1.1.

---

## 5. Open question — what does the monkey actually DO when triggered?

**This is the main thing to nail down with the dev taking over.** Options, with rough trade-offs:

- **Sound playback** (small speaker + DFPlayer Mini or ESP32 internal DAC) — funniest, most attention-grabbing, but risk of becoming the new noise problem. Could be a quiet "shhh" sample rather than a scream.
- **LED reaction** (eyes glow red, body pulses) — least disruptive, easy to ignore, may not actually change behavior.
- **Servo movement** (covers ears, shakes head, points) — visually fun, mechanical complexity, more to print and fit.
- **Combo** — LEDs always, sound only on sustained high level.
- **Silent / passive** — just logs to a dashboard, no in-room reaction. Boring but useful as a real metric.

**Recommendation to discuss:** start with LED-only for V1 to validate the noise detection, then add sound/servo in V1.1 once we know the trigger logic is solid.

---

## 6. Voice input — what do we mean?

The original brief mentioned "voice input." Two possible interpretations — the dev taking this over should confirm which:

1. **Microphone for ambient noise detection** (assumed primary meaning) — covered above.
2. **Voice commands** (e.g. say "monkey, calibrate" to set the threshold for current ambient level) — possible on ESP32-S3 with a small wake-word model, but adds real complexity. Suggest deferring to V2 unless there's a strong reason.

---

## 7. 3D-printing notes

- Design enclosure AFTER picking the reaction hardware (§5) — speaker grille, LED diffuser cutouts, or servo mount all change the model.
- Keep the mic port small but unobstructed — don't print a closed face over it.
- Use a snap-fit or single-screw back panel for access to the ESP32.
- Source/fork an existing CC-licensed monkey model rather than modeling from scratch.

---

## 8. Suggested milestones

1. **Breadboard prototype** — ESP32 + I2S mic, print dB values over serial. Confirm we can reliably distinguish "quiet office" from "loud office."
2. **Trigger logic** — threshold + dwell + cooldown, blink onboard LED on trigger.
3. **Pick reaction hardware** (resolve §5) and wire it in.
4. **Enclosure design** — 3D model around chosen components, print, fit, iterate.
5. **WiFi config page** (V1.1).

---

## 9. Decisions the dev needs to make / confirm

- [ ] Reaction type (§5) — recommend starting LED-only.
- [ ] Voice input interpretation (§6) — confirm "ambient noise" is what was meant.
- [ ] ESP32 variant — plain ESP32 vs ESP32-S3 (S3 if we ever want on-device voice).
- [ ] Mic model — INMP441 vs SPH0645 (either is fine; pick whichever is in stock locally).
- [ ] Monkey model — find a printable model or commission one.
- [ ] Threshold calibration approach — fixed in code, button on device, or WiFi config.

---

## 10. Out of scope / explicitly not doing in V1

- Battery operation.
- Multi-device coordination.
- Mobile app.
- Cloud / analytics / "noise heatmap of the office."
- Any kind of speech recognition or AI on-device.
