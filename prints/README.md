# prints/

Ready-to-slice Bambu Studio project file.

## `aben.3mf`

All 13 STL parts loaded onto two build plates with auto-arranged orientations. Open this file in Bambu Studio and you're ~3 clicks from sending to the printer.

### Quick steps

1. **Bambu Studio** → File → Open Project → `aben.3mf`
2. Top-right: confirm your printer model is selected (X1C / P1S / A1).
3. Top-left filament slots: load 3 filaments
   - Slot 1: light wood-fill PLA
   - Slot 2: dark wood-fill PLA  *(optional — used only for eye-board + muzzle)*
   - Slot 3: PETG black  *(optional — used only for yoke + servo bracket)*
4. Right-click each part → **Filament** → assign per the table in [`../PRINT.md`](../PRINT.md).
5. Apply slicer settings from `../PRINT.md` (or accept Bambu defaults for a generic first print).
6. Slice → Send to printer.

### Plate layouts (auto-arranged)

| Plate | Contents | Preview |
|---|---|---|
| 1 | head, torso_front, torso_back, arm_left, arm_right, leg_left, leg_right | [plate_1_preview.png](plate_1_preview.png) |
| 2 | base_disc, bottom_plate, eye_board, muzzle, yoke, servo_bracket | [plate_2_preview.png](plate_2_preview.png) |

You can re-arrange parts onto a single plate if you prefer (some legs/arms may need to be rotated vertical to fit — see [`../PRINT.md`](../PRINT.md) per-part orientation table).

### Important: verify per-part orientation before slicing

Auto-arrange optimizes for plate area, not for print quality. For best results check that:

- **Head** is chin-down on the bed (no support needed)
- **Arms** are standing vertically (shoulder end down) — layer lines run *along* the limb
- **Legs** are standing vertically (foot down) — same reason
- **Torso halves** are curved-seam side down — tree supports inside cavity only

If auto-arrange placed them on their sides, rotate manually before slicing.

### Regenerating this file

If you edit `cad/monkey.scad`:

```bash
# 1. Re-export STLs (see cad/README.md)
# 2. Regenerate the 3MF project:
"/Applications/BambuStudio.app/Contents/MacOS/BambuStudio" \
  --arrange 1 --orient 1 --allow-rotations \
  --outputdir "$(pwd)/prints" \
  --export-3mf "aben.3mf" \
  "$(pwd)"/stl/*.stl
```
