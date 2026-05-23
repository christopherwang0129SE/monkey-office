# CAD — Hør-ikke-abe parametric model

3D-print-ready geometry for the office monkey, V0.

## What's here

| File | Purpose |
|---|---|
| [`monkey.scad`](monkey.scad) | Single parametric source for every part. Edit dimensions at the top; everything downstream reflows. |
| [`../stl/*.stl`](../stl/) | Pre-exported STLs (11 parts) ready to drop into a slicer. |
| [`../stl/_assembly_preview.png`](../stl/_assembly_preview.png) | Rendered assembly preview (¾ view). |
| [`../stl/_assembly_front.png`](../stl/_assembly_front.png) | Rendered front elevation. |
| [`../stl/_assembly_side.png`](../stl/_assembly_side.png) | Rendered side elevation. |

## Honest scope of V0

**What this delivers:**
- Correct proportions matching [design-v1.md](../design-v1.md) §1.
- All mechanism mounts (servo cradle, shoulder pin bosses, tendon channels, ESP32 standoffs, back hatch, USB-C cutout).
- Printable, assemblable kit that validates the mechanism before investing in aesthetic surfacing.

**What this does NOT deliver:**
- Bojesen-quality organic surfacing. Pure-code geometry from primitives cannot reach that bar.
- The arms have sculpted elbow-ring detail but the limb taper is cylindrical, not the subtle Bojesen taper.
- The torso silhouette is an ovoid with a flat split — not the soft, hand-carved feel of the original.

**Path to the final aesthetic body:**
1. Print the V0 kit to validate fit, motion, and assembly.
2. Once the mechanism is proven, commission a sculptor (Blender/ZBrush) OR fork a CC-licensed Bojesen-style STL.
3. In the sculpted body, carve out the same internal cavities and mounting points defined here, OR import the printed-mount STLs from this file as solid bodies and boolean-union them into the sculpt.
4. The `servo_bracket.stl` (separate-printed mount) is the easiest path — it lets the sculpted body remain a single shell, with the mechanism living inside on a removable bracket.

## Parts list (11 STLs)

| Part | Filament | Notes |
|---|---|---|
| `head.stl` | light wood-fill | Print chin-down, no supports |
| `eye_board.stl` | dark wood-fill | Press-fits into face recess; drill 5.8mm holes after print if needed |
| `muzzle.stl` | dark wood-fill | Press-fits below eye-board |
| `torso_front.stl` | light wood-fill | Print cavity-side up, tree supports inside cavity only |
| `torso_back.stl` | light wood-fill | Same |
| `arm_left.stl` | light wood-fill + dark hand | Two-colour print (manual filament change at hand) or sand + dye |
| `arm_right.stl` | (same) | Mirror of left |
| `leg_left.stl` | light wood-fill | Print along long axis |
| `leg_right.stl` | (same) | Mirror |
| `yoke.stl` | PETG or ABS | Mechanical part — does NOT need wood-fill; PETG is stronger |
| `servo_bracket.stl` | PETG or ABS | Mechanical — same |

## Slicer settings (Bambu / Prusa / Cura)

| Setting | Wood-fill body parts | Mechanical parts (yoke, bracket) |
|---|---|---|
| Layer height | 0.12 mm | 0.16 mm |
| Wall loops | 4 | 3 |
| Top/bottom layers | 5 / 5 | 4 / 4 |
| Infill | 15% gyroid | 30% gyroid |
| Supports | Tree, only inside torso cavities | Auto, minimal |
| Print speed | ≤ 60 mm/s (wood-fill clogs fast) | 80–120 mm/s |
| Nozzle temp | per filament (typically 200–215 °C) | per filament |
| Bed adhesion | brim 4 mm on torso halves | skirt |

**Wood-fill warning:** wood-fill PLA is abrasive — use a hardened steel nozzle if you have one, or accept that a brass nozzle will wear faster.

## Post-processing (the quality lever)

This is the single biggest difference between "looks like a print" and "looks like wood."

1. Sand: 240 → 400 → 600 grit, working with the layer direction.
2. Wipe with a damp cloth, let dry fully.
3. Apply **food-safe boiled linseed oil** OR **Osmo Polyx Hardwax Oil**, two thin coats, 24h between.
4. Buff with a soft cloth between coats.

The wood fibres in the filament will absorb the oil and develop a real wood patina. Skip this step and the result looks like cheap PLA.

## Assembly order

1. Press 6mm black glass beads into `eye_board` (or print eyes inserted).
2. Press `eye_board` and `muzzle` into face recess on `head` — friction fit, dab of CA glue if loose.
3. Glue `torso_front` to `torso_back` along the seam (medium-set CA or two-part epoxy on the rim).
4. Mount SG90 servo into `servo_bracket`, then glue/screw bracket inside torso (front-half cradle).
5. Attach `yoke` to servo horn — friction-fit on the spline, secure with the supplied servo screw.
6. Thread tendon (2mm braided fishing line) through one yoke arm → up through torso channel → out shoulder hole → into arm tendon channel → tie inside the upper-arm pocket. Repeat for other side.
7. Insert shoulder pins (3mm steel pins or M3 bolts cut to length) through `torso` and `arm`, both sides.
8. Attach return spring or elastic band across the chest, looped through both arm bases.
9. Glue legs to torso bottom in seated pose.
10. Press head onto torso neck socket (friction fit; CA glue if permanent).
11. Connect ESP32-S3, mic, and USB-C breakout; mount via standoffs in torso back.
12. Close back hatch (magnetic — 4 × 5mm round neodymium magnets at corners).

## Regenerating STLs

If you change a dimension in `monkey.scad`, regenerate all parts:

```bash
cd cad
for p in head eye_board muzzle torso_front torso_back \
         arm_left arm_right leg_left leg_right yoke servo_bracket; do
  openscad -o "../stl/${p}.stl" -D "part=\"${p}\"" monkey.scad
done
```

Requires OpenSCAD ≥ 2023 (Apple Silicon: `brew install --cask openscad@snapshot`).

## Known V0 issues / TODO

- [ ] Curved torso seam (currently flat Y=0 split — design brief calls for a curved seam following spine + belly).
- [ ] Smoother arm taper (currently cylindrical with elbow ring — should hand-sculpt or use a Bezier sweep).
- [ ] Leg geometry: the seated pose is approximate. The shin angle and foot anchor need real CAD work.
- [ ] Magnetic back hatch: cutout is there but magnet pockets are not yet defined — add after first print to test fit.
- [ ] Ear geometry: currently flat disc, should be a shallow ovoid recess instead.
- [ ] Mic acoustic path needs prototyping — the 3mm port behind the eye-board may need to be larger or have a fabric/foam screen.
