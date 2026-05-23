# CAD — Aben parametric model

3D-print-ready geometry for Aben, the office noise monkey. **V0.3.**

## What's here

| File | Purpose |
|---|---|
| [`monkey.scad`](monkey.scad) | Single parametric source. Edit dimensions at the top — every part reflows. |
| [`../stl/*.stl`](../stl/) | 11 pre-exported STLs, ready for any slicer. |
| [`../stl/_assembly_front.png`](../stl/_assembly_front.png) | Front elevation render. |
| [`../stl/_assembly_side.png`](../stl/_assembly_side.png) | Side elevation. |
| [`../stl/_assembly_iso.png`](../stl/_assembly_iso.png) | 3/4 ISO view. |
| [`../stl/_triggered.png`](../stl/_triggered.png) | Triggered pose (arms raised). |

## Design philosophy

As simple as possible to print and assemble, as beautifully shaped as pure parametric geometry can be.

- **Standing pose** — Bojesen-iconic profile, long arms hanging at sides.
- **Arms at 130 mm** (59% of total height) — the signature Bojesen long-arm proportion.
- **Flowing shoulder** — torso swells outward at the shoulder via `hull()`, the arm root matches that curve. No clip-on look.
- **Organic taper** via `hull()` of spheres on every limb and the head.
- **Curved torso seam** — large cylinder cut, nearly invisible from front and back.
- **Wooden base disc** — separate part that hides USB-C and houses access; eliminates the visible back hatch.
- **Bottom hatch** on torso for servicing — invisible when standing on the base.
- **Alert rest posture** — arms hang slightly forward, suggesting "patient, watching."
- 10 cosmetic parts + 2 mechanism parts + 1 base = **13 STLs total**.

## Parts (11 STLs)

### Body (10 parts, wood-fill PLA)

| Part | Filament | Print notes |
|---|---|---|
| `head.stl` | light wood-fill | Chin-down orientation, no supports |
| `eye_board.stl` | dark wood-fill | Flat, press-fits into face recess |
| `muzzle.stl` | dark wood-fill | Flat, press-fits below eye-board |
| `torso_front.stl` | light wood-fill | Curved-seam side up, tree supports inside cavity only |
| `torso_back.stl` | light wood-fill | Same; includes ESP32 standoffs |
| `bottom_plate.stl` | light wood-fill | Magnetic access plate for torso bottom |
| `arm_left.stl` | light wood-fill | Lying flat, inner side down |
| `arm_right.stl` | light wood-fill | Mirror |
| `leg_left.stl` | light wood-fill | Standing, hip-down |
| `leg_right.stl` | light wood-fill | Mirror |
| `base_disc.stl` | wood-fill (any tone) | Flat, top-up. The "coaster" the monkey stands on |

### Mechanism (2 parts, PETG or ABS — strength matters more than aesthetics)

| Part | Filament | Print notes |
|---|---|---|
| `yoke.stl` | PETG/ABS | Small, prints flat |
| `servo_bracket.stl` | PETG/ABS | Bracket-side down, tree supports under cradle walls |

## Slicer settings

| Setting | Body parts (wood-fill) | Mechanism (PETG/ABS) |
|---|---|---|
| Layer height | 0.12 mm | 0.16 mm |
| Wall loops | 4 | 3 |
| Top/bottom | 5 / 5 | 4 / 4 |
| Infill | 15% gyroid | 30% gyroid |
| Supports | Tree, only inside torso cavities | Auto, minimal |
| Speed | ≤ 60 mm/s | 80–120 mm/s |
| Bed adhesion | brim 4 mm on torso halves | skirt |

Wood-fill PLA is abrasive — use a hardened steel nozzle if available.

## Post-processing (the quality lever)

This is where it stops looking like a print and starts looking like wood:

1. Sand: 240 → 400 → 600 grit, with layer direction.
2. Wipe clean, let dry.
3. Apply **boiled linseed oil** or **Osmo Polyx Hardwax Oil**, two thin coats, 24h between.
4. Buff with a soft cloth.

The wood fibres in the filament absorb the oil and develop a real wood patina.

## Hardware list

| Item | Qty | Notes |
|---|---|---|
| ESP32-S3 dev board (USB-C) | 1 | Mic-friendly variant preferred |
| INMP441 or SPH0645 I2S microphone | 1 | Mounted in torso top, pointing up into head neck cavity |
| SG90 micro servo | 1 | Standard 9g hobby servo |
| 6 mm black glass beads | 2 | Eyes — press-fit |
| 3 mm steel pins or M3 bolt + nylon nut | 2 | Shoulder pivots |
| 2 mm braided fishing line | ~60 cm | Tendons |
| Light return spring or 2 mm sewing elastic | ~20 cm | Arm return |
| 5×2 mm neodymium magnets | 4 | Back hatch retention |
| USB-C breakout board | 1 | Bottom-rear of torso |

## Assembly

1. Press black glass beads into both eye holes on `eye_board`.
2. Press `eye_board` and `muzzle` into the face recess on `head`. CA glue if loose.
3. Glue `torso_front` to `torso_back` along the curved seam (medium CA or two-part epoxy on the rim).
4. Mount the SG90 into `servo_bracket`; glue/screw the bracket inside the front torso cavity.
5. Press `yoke` onto the servo horn.
6. Run fishing line from yoke arm → up through torso → out the shoulder pin hole → into the arm tendon channel → tie inside the upper arm knot pocket. Repeat for the other side.
7. Insert 3 mm shoulder pins through `torso` and the base of each `arm`.
8. Stretch a light return spring or elastic band across the chest, looped through both arm bases.
9. Press leg hip-pegs into the leg sockets on the torso bottom; glue.
10. Press `head` onto the torso neck socket (friction fit; CA glue for permanence).
11. Mount the ESP32-S3 on the standoffs inside the back torso through the bottom hatch opening.
12. Insert mic at the top of the torso cavity, pointing up into the neck.
13. Press 4× 5×2 mm neodymium magnets into the `bottom_plate` pockets and into the torso. Snap the bottom plate in place.
14. Route the USB-C cable down from the ESP32 through the bottom plate cutout and out through the `base_disc` USB notch.
15. Stand the monkey on the `base_disc` — feet rest in the foot recesses.

## Regenerating STLs

If you change a dimension in `monkey.scad`:

```bash
cd cad
for p in head eye_board muzzle torso_front torso_back bottom_plate \
         arm_left arm_right leg_left leg_right base_disc yoke servo_bracket; do
  openscad -o "../stl/${p}.stl" -D "part=\"${p}\"" monkey.scad
done
```

Requires OpenSCAD ≥ 2023. Apple Silicon: `brew install --cask openscad@snapshot`.

## The gesture, revised

V0.3 confirms a geometric reality: with rigid 130 mm arms (the Bojesen-correct proportion), the hands **cannot literally cover the eyes**. The hand traces a 130 mm radius circle around the shoulder pivot; the eye is only ~25 mm from the shoulder — the hand always overshoots.

Three options:

1. **Embrace the "raised hands" gesture.** When triggered, arms sweep straight up, hands above head. Reads emotionally as *"this is too much"* / *"I throw up my hands."* Honest to the use case (office got too loud), keeps the geometry simple. **Recommended for V0.3.**
2. **2-piece elastic-articulated arms** (V1.0). Upper arm + forearm joined by elastic. Servo drives the upper arm only; forearm folds passively, hand lands on the face. True Bojesen articulation, more parts, more assembly complexity.
3. **Move the shoulder pivot to head height.** Makes the gesture literally "covering eyes" possible with a short rigid arm, but breaks the silhouette completely. Don't do this.

## Known open items

- **Torso surface banding.** Visible "panels" at hull control-point heights. Fix in V0.4 by using a single smoother shape or more intermediate spheres.
- **Servo hold buzz.** Add a mechanical end-stop inside the torso so the spring takes the holding force, not the servo.
- **Cable routing through leg.** USB-C cable currently exits through the bottom plate; long-term plan is to hollow one leg and route the cable through it into the base disc, for cleaner installation.
