# Tys-aben — Print Package

Alt du skal bruge for at printe og samle Tys-aben (den støj-reaktive abe der dækker sin egen mund).

---

## 1. Vælg variant

| Variant | Fil | Print-tid | Filament | Beskrivelse |
|---|---|---|---|---|
| **Wall (anbefalet)** | `tys-aben-wall-complete.stl` | ~6 timer | ~64 g | 125 mm høj, hænger på væg via keyhole. Inkluderer ekstern hub-boks. |
| **Desktop** | `tys-aben-desktop-complete.stl` | ~21 timer | ~167 g | 220 mm stående abe på rektangulær base 150×50 mm. |

**For office-deployment:** wall-varianten er bedst (per-zone, social signal hele rummet ser).
**For individual / executive desk:** desktop-varianten er bedst (premium look).

---

## 2. Print

1. Åbn én af `.stl`-filerne i **Bambu Studio** (eller PrusaSlicer / Cura)
2. Bekræft din printer-model (Bambu X1C / P1S / A1 fungerer alle)
3. Load filament:
   - **Lys wood-fill PLA** (Bambu Birch, Polymaker PolyWood Natural, ColorFabb WoodFill light)
   - **Mørk wood-fill PLA** (Bambu Walnut eller ColorFabb darker)
   - **PETG sort** valgfri til yoke + servo_bracket (PLA fungerer også i denne størrelse)
4. Højreklik hver del → Filament → tildel:
   - **Mørk**: `eye_board`, `muzzle`
   - **Sort (eller mørk)**: `yoke`, `servo_bracket`
   - **Lys**: alle øvrige
5. Læs [`PRINT-GUIDE.md`](PRINT-GUIDE.md) for præcise slicer-settings
6. **Slice → Send to printer**

**Vigtige settings:**
- Layer height: 0.12 mm (body), 0.16 mm (brackets)
- Walls: 4
- Infill: 15% gyroid
- Print speed: **max 60 mm/s** for wood-fill (vigtig — ellers jammer dysen)
- Nozzle: 0.4 mm hardened steel (wood-fill er abrasivt)

---

## 3. Hardware du skal købe / have klar

### Køb (kun ét)
- **1× SG90 micro servo** (~$2 Amazon/AliExpress)

### Du har (i Agent360-skuffe / dit forbrugeragent-projekt)
- I2S mikrofon-modul (~40 mm)
- USB-C breakout
- MCU motherboard (60×120 mm)

### Småhardware
| Item | Qty | Note |
|---|---|---|
| Sorte glasperler 6 mm (øjne) | 2 | Press-fit i eye_board |
| Stålpinde 3 mm × 40 mm (skuldre) | 2 | |
| Stålpinde 2 mm × 15 mm (albuer — kun wall V1.1) | 2 | Paperclip fungerer |
| Braided fishing line (tendoner) | 60 cm | |
| Sewing elastik 1.5 mm (kun wall V1.1) | 10 cm | Forearm return |
| Neodym-magneter 5 × 2 mm | 5 | 4 til hub-lid + 1 til bottom_plate |
| Vægskruer | 3 | 1 til monkey + 2 til hub |

---

## 4. Saml

Følg [`ASSEMBLY-GUIDE.md`](ASSEMBLY-GUIDE.md) trin-for-trin:

1. **Phase 1** — sand 240→400→600 grit + linolie (2 lag, 24t mellem)
2. **Phase 2** — sub-assemblies (hub interior, servo+yoke, 2-piece arme, mic-bracket)
3. **Phase 3** — body samling (elektronik → torso → arme → hoved → ben → luk)
4. **Phase 4** — vægmontering (monkey via keyhole + hub via 2 skruer)
5. **Phase 5** — firmware upload + tuning

Total samling-tid: ~3 timer arbejde + 48 timer finish-tørretid.

---

## 5. Firmware

Open Arduino IDE → install ESP32 board package → åbn [`firmware/tys-aben/tys-aben.ino`](firmware/tys-aben/tys-aben.ino) → upload.

Læs [`firmware/README.md`](firmware/README.md) for build-instruktioner + tuning af mic-threshold og servo-positioner.

---

## Filer i denne pakke

```
Tys-aben-Print-Package/
├── START-HER.md                       ← du er her
├── tys-aben-wall-complete.stl         ← print HER for wall (én fil, 17 parts)
├── tys-aben-desktop-complete.stl      ← print HER for desktop (én fil, 13 parts)
├── PRINT-GUIDE.md                     Bambu Studio settings + filament
├── ASSEMBLY-GUIDE.md                  Trin-for-trin samling
├── firmware/                          Arduino-ESP32 sketch
│   ├── tys-aben/tys-aben.ino          (compile-testet ✓)
│   └── README.md                      Build + tuning
├── individual-parts/                  Backup — alle parts som separate STL'er
│   ├── wall/                          (15 STLs — V1.1 med 2-piece arme + mic-bracket)
│   └── desktop/                       (13 STLs — V0.3 med rectangular base)
└── reference/
    └── peak-pose.png                  Visuelt mål — hånd-på-mund peak position
```

---

## Reference visuel

[`reference/peak-pose.png`](reference/peak-pose.png) — det her er hvad aben skal kunne lave når den er færdig: hænder kuppet over munden, øjnene kigger lige på dig over hænderne. Det er produktets pitch i ét billede.

---

## Hvis du sidder fast

- Slicer warning på `torso_front`: klik "Auto-repair model" (1 sek)
- Wood-fill jammer: drop print-speed til 50 mm/s
- Arms snapper ved albuen: tilføj en dråbe CA-lim ved hængslerne (assembly improvement)
- Servo virker ikke: check at den er SG90 (1.8 kg-cm torque), ikke en endnu mindre variant

---

**Caveat:** mekanikkens præcision af "hånd-på-mund" gestus kræver små justeringer af tendon-length ved samling (~5 min finkalibrering). Med Bojesen-quality finish (sand + linolie 2 gange) bliver det produkt-tier.

Hvis spørgsmål: hele projektet er på GitHub som **Agent360dk/monkey-office** (main branch, `3d Model officemonkey.dk/`-folder).
