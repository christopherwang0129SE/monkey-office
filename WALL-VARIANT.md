# Wall variant (V1.0-wall) — chat notes summary

Compact wall-mounted variant of Aben, designed under a **4-hour print budget**.

## Why it exists

The desktop V0.3 (220 mm standing on a base disc) is a beautiful Bojesen-tribute but ~21 hours of print time. For an office prototype where iteration speed matters, we needed something printable in an afternoon — and Bojesen's monkey is iconic for *hanging*, so wall-mount honours the heritage instead of fighting it.

## What changes vs V0.3 desktop

| | V0.3 desktop | **V1.0-wall** |
|---|---|---|
| Height | 220 mm | ~125 mm (incl. dangling legs) |
| Stance | Standing on base disc | Hangs from a keyhole on torso back |
| Total parts | 13 (incl. base disc) | 12 (no base) |
| Print plates | 2 | **1** |
| Print time (est.) | ~21 h | **~3.5 h** |
| Filament | ~310 g | ~55 g |
| Wall mount | — | Keyhole, 8 mm screw head, 10 mm slot |

## Files

- **CAD source:** [`cad/monkey-wall.scad`](cad/monkey-wall.scad)
- **STLs:** [`stl/wall/`](stl/wall/) — 12 parts
- **Bambu Studio project:** [`prints/aben-wall.3mf`](prints/aben-wall.3mf) — all parts on one plate
- **Renders:** [`stl/wall/_front.png`](stl/wall/_front.png), `_side.png`, `_back.png`, `_iso.png`, `_midmotion.png`, `_triggered.png`, `_wall_mockup.png`

## Design moves carried over from V0.3

- Bojesen-long arms (60% of body height)
- Organic taper via `hull()` of spheres
- Flowing shoulder caps (no clip-on look)
- Soft chin transition
- Hidden mic port behind one ear
- Curved torso seam
- Alert rest posture (arms slightly forward)

## Design moves NEW to wall variant

- **Keyhole mount** on torso back — 8 mm circle + 10 mm slot, recessed so the screw head sits flush inside the body
- **Dangling legs** — visible from front/side, glued into hip sockets, fully passive
- **Single magnet** on the small bottom hatch (vs. 4 magnets on desktop)
- **All parts on one print plate** — no need to swap mid-print

## Honest constraints

- The SG90 servo sets the **lower limit** on torso size. Cannot shrink torso below ~32 × 22 × 33 mm external without switching to a sub-micro servo (SG51R).
- Smaller eye holes (3.5 mm) means smaller beads or hand-painted dots.
- Wall thickness dropped from 2.4 → 2.0 mm — still strong enough but more brittle on long thin parts like arms.
- USB-C cable exits down through the bottom plate. Routes along the wall behind the monkey.

## How to print

1. Open `prints/aben-wall.3mf` in Bambu Studio
2. Confirm your printer (X1C / P1S / A1) is selected
3. Load 2 filaments: light wood-fill PLA + dark wood-fill PLA (PETG optional for yoke/bracket — they can also be PLA at this small size)
4. Right-click each part → Filament → assign per part name
5. Slice → Send to printer

Per-part settings table is in [`PRINT.md`](PRINT.md) — same wood-fill rules apply (≤60 mm/s outer wall, hardened steel nozzle, sand + linseed-oil finish for the wood look).
