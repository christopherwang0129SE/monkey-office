OfficeMonkey 🙈 🙉 🙊


A 3D-printed desk monkey that listens to the room and reacts when the office gets too loud — so no one has to be the person who shushes everyone.



Danish name: Tys aben ("Hush the monkey")
Website: officemonkey.dk
Lovable project: lovable.dev/projects/6d5c936e-dc8c-4e85-afaa-a0ec67a89f7e


What it is

OfficeMonkey is a small, 3D-printed monkey that sits on a desk or shelf in an open office. Inside is an ESP32 with a digital microphone that continuously measures ambient sound level. When the noise crosses a threshold (sustained chatter, a loud meeting bleeding into the open floor), the monkey reacts — gently signalling "it's a bit loud in here" without anyone having to say it out loud.

It started as a hackathon project by Agent360 and collaborators.

How it works


An I2S MEMS microphone (INMP441 or SPH0645) samples ambient audio.
The ESP32 computes a short-window RMS → smoothed dB-ish value.
If the level stays above a configurable threshold for a configurable duration, the monkey triggers a reaction (LEDs, sound, or servo movement — see roadmap).
A cooldown period prevents re-triggering on every noise spike.


Threshold, dwell time, and cooldown are hard-coded in V1 and configurable via a small WiFi-served page in V1.1.

Repository structure

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


Note: Mokey-product-plan.md has a typo in the filename (should be Monkey-). Worth fixing on a rename PR.



Hardware — bill of materials

Target BOM: under $25 per unit.

PartNotesApprox costESP32 dev board (ESP32-S3 recommended)Built-in WiFi/BT, I2S mic support, USB-C~$5–10I2S MEMS microphone (INMP441 or SPH0645)Digital mic, cleaner than analog for noise-level work~$3Reaction output (LEDs / speaker / micro-servo)TBD — see roadmap$2–103D-printed enclosurePLA, printed from files in stl/Filament onlyUSB-C cable + 5V supply~$5

Software stack


Firmware: Arduino-ESP32 (C++) or ESP-IDF. MicroPython avoided for V1 — audio sampling timing is easier in C.
Audio sampling: I2S DMA → RMS → smoothed dB estimate.
Trigger logic: threshold + dwell + cooldown.
CAD: OpenSCAD (parametric, so the enclosure can be re-generated when hardware choices change).
Tooling: Python scripts for print helpers / calibration.
Marketing site: Lovable (React + Vite), deployed at officemonkey.dk.


Getting started


Firmware and wiring are still in progress — this section will grow as V1 comes together.



Print the enclosure


Grab an STL from stl/ (or open the OpenSCAD source in cad/ if you want to tweak dimensions).
Slice with your printer's usual PLA profile. See PRINT.md for orientation and support notes.
Print the back panel separately so the electronics stay accessible.


Flash the firmware

Coming soon — firmware code will live in a firmware/ folder once V1 is written. See Mokey-product-plan.md §4 for the intended stack.

Configure

V1 uses hard-coded threshold/dwell/cooldown constants at the top of the firmware. V1.1 will add a WiFi config page.

Roadmap

V1 (in progress)


 Breadboard prototype: ESP32 + I2S mic, dB values over serial
 Trigger logic (threshold + dwell + cooldown)
 Pick reaction hardware (LED-only recommended for V1)
 Fit electronics into enclosure, iterate on print


V1.1


 WiFi config page for threshold / sensitivity
 Sound and/or servo reaction on top of LEDs


V2 (ideas)


 Voice commands ("monkey, calibrate") on ESP32-S3
 Multi-monkey coordination across a floor
 Battery / portable operation


Explicit non-goals for V1: battery, cloud dashboard, mobile app, on-device speech recognition.

Team


Agent360 — hardware, product, 3D design
Christopher Wang
…add remaining teammates here


License

TBD — recommend MIT for the code and Creative Commons Attribution (CC BY 4.0) for the 3D models. Open an issue if you disagree before we commit to it.

Links

Website: officemonkey.dk
Lovable project: lovable.dev/projects/6d5c936e-dc8c-4e85-afaa-a0ec67a89f7e
Product plan: Mokey-product-plan.md
Design notes: design-v1.md, design-critique.md
Research: Research.md
Print instructions: PRINT.md

Project contentGithubCreated by youAdd PDFs, documents, or other text to reference in this project.
