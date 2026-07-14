# OfficeMonkey 🙈 🙉 🙊

> A 3D-printed desk monkey that listens to the room and reacts when the office gets too loud — so no one has to be the person who shushes everyone.

**Danish name:** *Tys aben* ("Hush the monkey")

🌐 [Website](https://www.officemonkey.dk) &nbsp;·&nbsp; 🎨 [Lovable project](https://lovable.dev/projects/6d5c936e-dc8c-4e85-afaa-a0ec67a89f7e) &nbsp;·&nbsp; 📄 [Product plan](./Mokey-product-plan.md)

Built by a team of five at **The Boring Hackathon 2026** — a Copenhagen hackathon organised by [Milo.AI](https://milo.ai) and [Iværksætter Netværk Denmark](https://www.facebook.com/groups/ivaerksaetternetvaerk).

---

## What it is

OfficeMonkey is a small, 3D-printed monkey that sits on a desk or shelf in an open office. Inside is an ESP32 with a digital microphone that continuously measures ambient sound level. When the noise crosses a threshold (sustained chatter, a loud meeting bleeding into the open floor), the monkey reacts — gently signalling "it's a bit loud in here" without anyone having to say it out loud.

## How it works

1. An I2S MEMS microphone (INMP441 or SPH0645) samples ambient audio.
2. The ESP32 computes a short-window RMS → smoothed dB-ish value.
3. If the level stays above a configurable threshold for a configurable duration, the monkey triggers a reaction (LEDs, sound, or servo movement — see [Roadmap](#roadmap)).
4. A cooldown period prevents re-triggering on every noise spike.

Threshold, dwell time, and cooldown are hard-coded in V1 and configurable via a small WiFi-served page in V1.1.

## The hackathon build

The Boring Hackathon 2026 gave us a fixed sprint to go from idea to something tangible. In that window we:

- Scoped the product, hardware, and V1 roadmap.
- Designed a parametric enclosure in OpenSCAD and 3D-printed a working miniature prototype.
- Built [officemonkey.dk](https://www.officemonkey.dk) as the product site, using Lovable for rapid iteration.
- Delivered a live demo and pitch at the end of the day.
- Posted a launch listing to the Iværksætter Netværk Denmark community as a first go-to-market signal.

## Repository structure

```
.
├── 3d Model officemonkey.dk/     Marketing 3D model for the website
├── Tys-aben-Print-Package/       Ready-to-print bundle of the enclosure
├── cad/                          OpenSCAD source for the enclosure
├── prints/                       Reference/finished print files
├── stl/                          Exported STL files for printing
├── Mokey-product-plan.md         V1 product plan and scope
├── PRINT.md                      Printing instructions
├── Research.md                   Background research
├── design-v1.md                  V1 design notes
├── design-critique.md            Design critique notes
└── three-wise-monkeys-website-inspiration.md
```

> Note: `Mokey-product-plan.md` has a typo in the filename (should be `Monkey-`). Worth fixing on a rename PR.

## Hardware — bill of materials

Target BOM: **under $25** per unit.

| Part | Notes | Approx cost |
| --- | --- | --- |
| ESP32 dev board (ESP32-S3 recommended) | Built-in WiFi/BT, I2S mic support, USB-C | ~$5–10 |
| I2S MEMS microphone (INMP441 or SPH0645) | Digital mic, cleaner than analog for noise-level work | ~$3 |
| Reaction output (LEDs / speaker / micro-servo) | TBD — see [Roadmap](#roadmap) | $2–10 |
| 3D-printed enclosure | PLA, printed from files in `stl/` | Filament only |
| USB-C cable + 5V supply | | ~$5 |

## Software stack

- **Firmware:** Arduino-ESP32 (C++) or ESP-IDF. MicroPython avoided for V1 — audio sampling timing is easier in C.
- **Audio sampling:** I2S DMA → RMS → smoothed dB estimate.
- **Trigger logic:** threshold + dwell + cooldown.
- **CAD:** OpenSCAD (parametric, so the enclosure can be re-generated when hardware choices change).
- **Tooling:** Python scripts for print helpers / calibration.
- **Marketing site:** Lovable (React + Vite), deployed at [officemonkey.dk](https://www.officemonkey.dk).

## Getting started

> Firmware and wiring are still in progress — this section will grow past the hackathon miniature as V1 comes together.

### Print the enclosure

1. Grab an STL from `stl/` (or open the OpenSCAD source in `cad/` if you want to tweak dimensions).
2. Slice with your printer's usual PLA profile. See [PRINT.md](./PRINT.md) for orientation and support notes.
3. Print the back panel separately so the electronics stay accessible.

### Flash the firmware

*Coming soon* — firmware code will live in a `firmware/` folder once V1 is written. See [Mokey-product-plan.md](./Mokey-product-plan.md) §4 for the intended stack.

### Configure

V1 uses hard-coded threshold/dwell/cooldown constants at the top of the firmware. V1.1 will add a WiFi config page.

## Roadmap

**V1 (in progress)**
- [ ] Breadboard prototype: ESP32 + I2S mic, dB values over serial
- [ ] Trigger logic (threshold + dwell + cooldown)
- [ ] Pick reaction hardware (LED-only recommended for V1)
- [ ] Fit electronics into enclosure, iterate on print

**V1.1**
- [ ] WiFi config page for threshold / sensitivity
- [ ] Sound and/or servo reaction on top of LEDs

**V2 (ideas)**
- [ ] Voice commands ("monkey, calibrate") on ESP32-S3
- [ ] Multi-monkey coordination across a floor
- [ ] Battery / portable operation

Explicit non-goals for V1: battery, cloud dashboard, mobile app, on-device speech recognition.

## Team

Built by a team of five at The Boring Hackathon 2026:

- [Agent360](https://github.com/Agent360dk) — hardware, product, 3D design
- [Christopher Wang](https://github.com/christopherwang0129SE)
- *…add remaining three teammates here*

## License

TBD — recommend **MIT** for the code and **Creative Commons Attribution (CC BY 4.0)** for the 3D models. Open an issue if you disagree before we commit to it.

## Links

| | |
| --- | --- |
| 🌐 Website | [www.officemonkey.dk](https://www.officemonkey.dk) |
| 🎨 Lovable | [Open in Lovable](https://lovable.dev/projects/6d5c936e-dc8c-4e85-afaa-a0ec67a89f7e) |
| 📄 Product plan | [Mokey-product-plan.md](./Mokey-product-plan.md) |
| 🎨 Design notes | [design-v1.md](./design-v1.md) · [design-critique.md](./design-critique.md) |
| 🔬 Research | [Research.md](./Research.md) |
| 🖨️ Print instructions | [PRINT.md](./PRINT.md) |
