# PRINT.md — Aben on a Bambu Lab printer

> One-page guide. Open the project file, slice, print. Total time: ~21 hours of printing across 13 parts.

---

## Quick start

1. Open **Bambu Studio** → File → Open Project → [`../prints/aben.3mf`](../prints/aben.3mf).
2. Confirm your printer model (X1C / P1S / A1) is selected, top-right.
3. Load filaments (see [filament table](#filaments-3-colors) below).
4. Assign filaments per part (right-click → Filament).
5. Apply settings from [§ Bambu Studio profile](#bambu-studio-profile-paste-these-values).
6. Slice → Send to printer.

Plate layouts and per-plate part lists: see [`../prints/README.md`](../prints/README.md).

If you'd rather start from STLs, see [§ Manual setup](#manual-setup-without-the-3mf).

---

## Filaments (3 colors)

| Slot | Filament | Used for | Approx. need |
|---|---|---|---|
| **1. Light wood** | Bambu PLA Wood "Birch" / Polymaker PolyWood natural / ColorFabb WoodFill light | Body, head, arms, legs, bottom plate | ~250 g |
| **2. Dark wood** | Bambu PLA Wood "Walnut" / ColorFabb WoodFill darker | Eye-board, muzzle | ~5 g |
| **3. PETG black** | Bambu PETG-HF black | Yoke, servo bracket (hidden inside) | ~15 g |
| 4. *Optional contrast wood* | Medium wood-fill | Base disc (if you want a two-tone object) | ~40 g |

**Total filament: ~310 g.** Cheap. You can do it all in light wood if you don't have multiple filaments — face inserts in dark wood is purely cosmetic.

**Nozzle:** 0.4 mm **hardened steel** strongly recommended. Wood-fill PLA is abrasive; brass nozzles wear visibly within a few prints.

---

## Print in 3 phases (recommended — don't print everything at once)

**Phase 1 — Validate the mechanism (~1 h, ~10 g filament)**
- Print: `servo_bracket.stl`, `yoke.stl`, `bottom_plate.stl`
- Goal: fit-check the SG90 in the bracket and the yoke on its horn before committing to the rest of the print.

**Phase 2 — Validate the torso cavity (~5 h, ~80 g)**
- Print: `torso_front.stl`, `torso_back.stl`, `base_disc.stl`
- Goal: confirm the servo bracket fits inside the assembled torso, that the bottom plate seals magnetically, and that the monkey will stand stable on the base.

**Phase 3 — Finish the body (~15 h, ~220 g)**
- Print: `head.stl`, `arm_left.stl`, `arm_right.stl`, `leg_left.stl`, `leg_right.stl`, `eye_board.stl`, `muzzle.stl`
- Goal: complete the sculpture.

If Phase 1 or 2 reveals a fit issue, you adjust `../cad/monkey.scad`, re-export only the affected STLs, and re-print without having wasted 18 hours.

---

## Per-part settings

| Part | Filament | Orientation on bed | Supports | Layer height | Est. time |
|---|---|---|---|---|---|
| `head.stl` | Light wood | Chin-down (flat side of chin to bed) | None | 0.12 mm | ~3 h |
| `torso_front.stl` | Light wood | Curved-seam side down | Tree, inside cavity only | 0.12 mm | ~2 h |
| `torso_back.stl` | Light wood | Curved-seam side down | Tree, inside cavity only | 0.12 mm | ~2 h |
| `bottom_plate.stl` | Light wood | Flat (magnet pockets face up) | None | 0.16 mm | ~30 min |
| `arm_left.stl` | Light wood | Shoulder end **down** (arm standing vertically) | None | 0.12 mm | ~2 h |
| `arm_right.stl` | Light wood | Same | None | 0.12 mm | ~2 h |
| `leg_left.stl` | Light wood | Foot down (leg standing vertically) | Minimal — foot overhang | 0.12 mm | ~2.5 h |
| `leg_right.stl` | Light wood | Same | Same | 0.12 mm | ~2.5 h |
| `eye_board.stl` | Dark wood | Flat | None | 0.12 mm | ~10 min |
| `muzzle.stl` | Dark wood | Flat | None | 0.12 mm | ~5 min |
| `base_disc.stl` | Light or medium wood | Flat (USB notch facing right) | None | 0.16 mm | ~2 h |
| `yoke.stl` | PETG black | Flat | None | 0.16 mm | ~10 min |
| `servo_bracket.stl` | PETG black | Bracket-side down | Tree under cradle walls | 0.16 mm | ~30 min |

**Why limbs print vertically:** layer lines run *along* the limb. When you oil-finish wood-fill PLA, layer lines read as faux wood grain. Vertical grain on a vertical limb = correct.

---

## Bambu Studio profile (paste these values)

| Setting | Wood-fill PLA (body) | PETG (mechanism) |
|---|---|---|
| Printer | Bambu X1C / P1S / A1 | Same |
| Build plate | **Textured PEI** | Textured PEI |
| Layer height | 0.12 mm | 0.16 mm |
| First layer height | 0.20 mm | 0.20 mm |
| Wall loops | **4** | 3 |
| Top / bottom layers | 5 / 5 | 4 / 4 |
| Infill density | **15 %** | 30 % |
| Infill pattern | **Gyroid** | Gyroid |
| Print speed (outer wall) | **40 mm/s** | 80 mm/s |
| Print speed (inner wall / infill) | **60 mm/s** | 120 mm/s |
| Nozzle temp | 215 °C | 240 °C |
| Bed temp | 65 °C | 75 °C |
| Cooling fan | 60 % | 30 % (PETG hates over-cooling) |
| Retraction | 0.8 mm @ 30 mm/s | Filament default |
| Bed adhesion | Brim 4 mm (torso halves only) | Skirt |
| Pressure advance | Filament default | Filament default |

**Crucial wood-fill rule:** keep speed below **60 mm/s**. Wood-fill PLA clogs the nozzle if pushed faster — the wood fibres melt unevenly and jam.

---

## Post-processing (the quality lever)

This is where the print stops looking like a 3D print and starts looking like a wooden object. Skip this and you have a competent prototype. Do this and you have an object you want to keep on your desk.

1. **Sand** in stages: 240 → 400 → 600 grit, with the layer direction.
2. Wipe clean with a damp cloth, let dry fully.
3. **Apply boiled linseed oil** or Osmo Polyx Hardwax Oil — two thin coats, 24 h between.
4. Buff with a soft cloth between coats.

The wood fibres in wood-fill PLA absorb the oil and develop a real wood patina. The layer lines, post-oil, look like grain.

---

## Hardware bill of materials (for the assembled product, not the print itself)

| Item | Qty | Notes |
|---|---|---|
| ESP32-S3 dev board with USB-C | 1 | Any common variant |
| INMP441 or SPH0645 I2S microphone | 1 | Mounted at top of torso cavity |
| SG90 micro servo | 1 | Standard 9 g hobby servo |
| 6 mm black glass beads | 2 | Eyes — press-fit |
| 3 mm steel pins (40 mm long) | 2 | Shoulder pivots |
| 2 mm braided fishing line | 60 cm | Tendons |
| Light return spring or 2 mm sewing elastic | 20 cm | Arm return-to-rest |
| 5 × 2 mm neodymium magnets | 4 | Bottom plate retention |
| USB-C breakout board | 1 | Routed through bottom plate + base disc notch |

---

## Manual setup (without the 3MF)

If you'd rather build the print plate yourself:

1. Open Bambu Studio, select your printer.
2. File → Import → select all 13 `.stl` files from `../stl/`.
3. Apply the orientations from the per-part table above (right-click → Lay flat, or use the rotate tool).
4. Apply the filament assignment: light wood for body parts, dark wood for eye_board + muzzle, PETG for yoke + servo_bracket.
5. Apply profile settings from the table above.
6. Arrange on the plate. (Tip: torso halves and base disc take the most room — arrange them first, fit everything else in the gaps. You may need 2 plates.)
7. Slice → review the preview → Send to printer.

---

## Troubleshooting

| Symptom | Cause | Fix |
|---|---|---|
| Wood-fill jams mid-print | Speed too high | Drop to 50 mm/s outer wall |
| Stringing on wood prints | Retraction too short for wood-fill | Retraction → 1.0 mm |
| Torso halves don't meet at seam | Print warp on tall thin walls | Increase brim to 6 mm; ensure bed is enclosed/heated |
| Arms snap at shoulder | Layer adhesion weak | Print arms vertically (shoulder down) — layer lines should run along the arm, not across it |
| Magnets don't seat in bottom plate | Hole slightly tight | Drill 5.2 mm pocket to 5.5 mm after print |
| SG90 doesn't fit in bracket | Tolerance variation | Sand bracket cradle walls; or edit `sg90_body_w/l` in `../cad/monkey.scad` +0.4 mm and re-export |

---

## Print order summary

```
Phase 1 (validate mechanism)        ~1 h
  └── servo_bracket, yoke, bottom_plate

Phase 2 (validate torso)            ~5 h
  └── torso_front, torso_back, base_disc

Phase 3 (finish body)               ~15 h
  └── head, arm_left, arm_right, leg_left, leg_right, eye_board, muzzle

TOTAL                              ~21 h / ~310 g filament
```
