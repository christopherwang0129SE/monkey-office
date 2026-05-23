# cad.atech.dev — Tys-aben prompt

> Paste-ready prompt for generating the full 3D-printable Tys-aben (Wall variant, V1.1) including the external hardware hub. English, hyper-specified, includes every locked design decision from our iteration.

---

## The prompt

```
DESIGN A 3D-PRINTABLE MECHANICAL WOODEN MONKEY FIGURINE — "TYS-ABEN"

Project: A small, wall-mounted, 3D-printed wooden monkey figurine in
the tradition of Kay Bojesen's 1951 teak monkey. It contains a
microcontroller, an I2S microphone, and a servo. When the ambient
noise in an office exceeds a configurable threshold, the servo
actuates two-piece articulated arms via internal tendons so that the
monkey's two hands cup gently over its own mouth — an Iwazaru
("speak no evil") gesture adapted as a silent social signal: the
monkey is silently telling the room to be quiet. Eye contact with
the viewer is preserved throughout the gesture (eyes remain visible
above the cupped hands).

Generate FDM-printable STL geometry for every part listed below.
All parts must be MANIFOLD AND WATERTIGHT. Units: millimetres.

==============================================================
PART 1 — THE MONKEY (WALL VARIANT V1.1)
==============================================================
Total height when mounted: 125 mm (legs dangling).
Mounting: a keyhole slot on the back of the torso for a single
screw head (8 mm diameter circular hole transitioning into a
2.8 mm × 10 mm vertical slot, recessed so the screw head sits
flush inside the body, located 25% up from torso center on the
back face).

OVERALL FORM AND PROPORTIONS
- Head: a near-perfect sphere, 38 mm wide × 37 mm deep × 44 mm tall,
  with a softly rounded chin plane (NOT flat-cut). No neck. Two
  flush vestigial ear-discs (~9 mm diameter) on the sides, barely
  perceptible from the front.
- Torso: egg-shaped, broadest at the shoulders and tapering to the
  hips. External dimensions 38 × 28 × 52 mm. Two front/back halves
  split along a curved seam following the spine-and-belly midline
  (seam radius approximately 120 mm so the seam reads as a body
  contour, not an assembly line).
- Shoulders: flow into the torso as one continuous form — the torso
  swells outward and the arm grows from it. NO right-angle clip-on
  shoulder. Use hull operations to blend the shoulder ball into the
  torso ovoid.
- Arms: TWO-PIECE per side (see PART 1B below). Total arm length
  approximately 75 mm; upper arm and forearm are each ~37 mm long.
- Legs: dangling passively from the hip sockets. Each leg is
  ~55 mm long, 15 mm wide at the foot, 13 mm at the knee. Feet are
  slightly toed-out (~10°). Toe tips lift forward-and-slightly-up
  like slipper toes.
- At-rest posture: arms hang fully along the sides with a 5° forward
  inclination of the upper arm at the shoulder (alert, not relaxed).
  Eyes always forward, attentive.

FACE
- A shallow ovoid recess on the front of the head, 3 mm deep.
- An eye-board insert: a horizontal lozenge 22 mm wide × 8 mm tall,
  2.8 mm thick, with a faint downward bow at center (smile-line),
  press-fit into the upper half of the face recess. Printed
  separately in a contrasting darker wood-tone filament.
- A muzzle insert: a small round disc 8.5 mm diameter, 2.5 mm
  thick, press-fit just below the eye-board in the lower half of
  the face recess. Same darker wood tone.
- Two black glass bead eyes (6 mm diameter) press-fit into 5.8 mm
  holes in the eye-board with 11 mm spacing center-to-center.
- A subtle brow ridge above the eye-board and shallow cheek planes
  flanking the muzzle. These give the face skeletal structure even
  before the inserts are placed.
- NO mouth, NO nostrils, NO painted features.

PART 1A — TORSO INTERIOR (HOLLOW CAVITY FOR ELECTRONICS)
Internal cavity must accommodate the following hardware, with the
listed clearances:
- SG90 micro servo: external body 23 × 12.5 × 22.5 mm. Mounts
  centered in the torso with the output shaft pointing up. Held by
  a printed cradle (servo_bracket) that snaps into the torso.
- I2S microphone board: 39.5 × 10.8 × 19.5 mm. Mounted vertically
  in the upper torso so the mic capsule points up into the neck
  cavity (acoustic waveguide). The eye-board insert hides a small
  sound port from the outside.
- Tendon channels: two parallel internal channels, 2.0 mm
  diameter, running from the servo yoke up through the torso and
  exiting at each shoulder pin axis. PTFE-lining slot 2.4 mm
  diameter for low-friction tendon routing.
- Shoulder pin holes: 2.5 mm diameter through-holes at the top of
  the torso, one at each side, into which a 3 mm steel pin
  inserts to hold the upper arm.
- Bottom plate: 24 × 20 × 2 mm rounded rectangle with a 14 × 8 mm
  cable cutout for the wire bundle exiting the torso going down to
  the external hub. Retained by a single 5 mm magnet in a 5.2 × 2.2
  mm pocket.
- Internal wall thickness: 2.0 mm uniform.

PART 1B — TWO-PIECE ARTICULATED ARM (THE KEY MECHANISM)
Each arm consists of:
- upper_arm (left + right): 37 mm long, tapered from 14 mm
  diameter at the shoulder ball, swelling to 15 mm in the upper
  bicep, then tapering to 12 mm near the elbow knuckle. Contains:
    • A 2.5 mm transverse shoulder pin hole at the proximal end.
    • A 2.2 mm transverse elbow pin hole at the distal end.
    • A 2.0 mm tendon channel running the length of the limb,
      offset slightly toward the body side, EXITING THE FRONT-FACE
      of the elbow knuckle so the same tendon can cross the joint
      into the forearm.
    • A small clearance slot on the front face of the elbow so the
      forearm's top sphere has room to fold against the upper arm
      without binding (~16 × 8 × 6 mm relief).
- forearm (left + right): 37 mm long, tapered from 13 mm at the
  elbow knuckle to 10 mm in the middle, to 9 mm at the wrist, with
  a 14 mm sphere at the hand end that has a subtle inward
  concave dip on the palm-facing side (a "wooden mitten" shape —
  NOT a claw, NOT a pointed shape, NOT separated fingers).
  Contains:
    • A 2.2 mm transverse elbow pin hole at the proximal end.
    • A 2.0 mm tendon channel ENTERING the elbow knuckle on the
      front-back face (mating with the upper arm's exit), running
      ~55% of the forearm length, terminating in a small 3.5 mm
      knot pocket where the fishing-line tendon is tied off.
- Mechanism: a 2 mm steel pin (15 mm length, typical music wire or
  bent paperclip) joins upper_arm and forearm at the elbow. The
  same single tendon passes through the upper arm, exits the front
  of the elbow, re-enters the forearm, and terminates inside the
  forearm. When the servo retracts the tendon:
    1. The upper arm rotates ~75° forward about the shoulder pin.
    2. The tendon continues to shorten across the elbow, pulling
       the forearm to fold ~90° forward relative to the upper arm.
    3. Both rotations happen simultaneously, bringing the hand
       through an arc that lands the palm-cup at MUZZLE LEVEL,
       approximately 15 mm forward of the shoulder pin and 18 mm
       above it — covering the lower half of the face. The eyes
       (eye-board, glass beads) REMAIN FULLY VISIBLE ABOVE THE
       CUPPED HANDS.

PART 1C — YOKE
A small printed part that mounts on the servo horn (5 mm shaft
hole). Has two horizontal arms with 4 mm diameter holes 10 mm
apart from the center, each carrying one tendon termination knot.

PART 1D — SERVO BRACKET
A printed cradle that holds the SG90 servo body firmly inside the
torso. External dimensions ~22 × 31 × 25 mm. Snaps into printed
ribs inside the torso front half. Provides a flat top surface for
the servo's mounting tabs and a circular bore for the output shaft.

==============================================================
PART 2 — EXTERNAL HARDWARE HUB
==============================================================
A separate matching wooden enclosure that houses the larger
hardware that cannot fit inside the monkey itself. Designed to be
wall-mounted directly below the monkey or to sit on the desk
behind it.

EXTERIOR
- Overall: 70 × 145 × 24 mm rectangular prism with rounded vertical
  corners (corner radius 6 mm).
- Same wood-fill PLA finish as the monkey itself — reads as a
  deliberately matching object, not a random brick.
- Two 4.5 mm through-holes on the back wall for wall-mounting
  screws, 24 mm apart vertically, centered horizontally.

INTERIOR (65 × 140 × 21.5 mm cavity, 2.5 mm wall thickness)
Must accommodate:
- A motherboard 60 × 7 × 120 mm lying flat on the floor of the
  cavity. Held in place by four printed pegs at the corners
  (4 mm diameter, 4 mm tall) that act as positional locators.
- A USB-C breakout (19.5 × 10.2 × 19.8 mm) soldered into the rear
  wall. The hub has a 20.5 × 11.5 mm rounded cutout in the rear
  wall for the USB-C port to be accessible from outside.
- A cable inlet on the TOP rear edge (14 × 8 mm rounded cutout)
  through which the wire bundle from the monkey enters: USB-C
  power up to the monkey, mic data lines down to the motherboard,
  servo control wires.

LID
- A separate 70 × 145 × 5 mm top lid with a 2 mm step that drops
  into the cavity opening.
- Four 5.2 mm diameter × 2.6 mm deep magnet pockets in each corner
  on both the lid (underside) and the box top rim, so the lid
  snaps shut magnetically. Four 5 × 2 mm neodymium magnets total.

==============================================================
COMMON CONSTRAINTS — ALL PARTS
==============================================================
PRINTING
- FDM 3D printing on a Bambu Lab or Prusa-class printer.
- 0.4 mm hardened-steel nozzle (wood-fill PLA is abrasive).
- 0.12 mm layer height for body, head, limbs; 0.16 mm acceptable
  for base and brackets.
- 4 walls minimum; 15 % gyroid infill.
- Max print speed for wood-fill PLA: 60 mm/s outer wall.
- No part should require excessive supports — design with FDM
  printability in mind (overhangs ≤ 45° where possible).
- Each printable part must be a separate STL file.

MATERIAL & FINISH
- Body, head, limbs, base: light birch-toned wood-fill PLA, satin
  oiled finish (boiled linseed oil), warm honey hue, visible
  vertical grain.
- Eye-board insert + muzzle insert: darker walnut-toned wood-fill
  PLA.
- Yoke and servo bracket: PETG black (mechanical strength) or
  same PLA at this small size.
- Hub: same light or medium wood-fill PLA as monkey body.

THE LINE SHOULD SMILE (Bojesen design rule)
At every transition — chin, shoulder, elbow, foot tip, eye-board
edges — the curve should arc subtly UPWARD relative to a viewer
holding the object. No sharp fillets. No right angles. Every
transition is a radius. This is THE rule that separates a competent
3D-printed figurine from a generational-quality designed object.

NEVER VISIBLE (anywhere on the assembled product)
- No visible screws on any external surface of the monkey body.
- No visible USB-C port on the monkey (USB-C is on the HUB, not
  the monkey).
- No LEDs.
- No exposed cables.
- No servo horn peeking out.
- No painted features, no cartoon eyes, no mouth, no nostrils.
- No separated fingers, no tail.
- No brand marks, no logos, no text.
- No assembly seams beyond the natural torso front/back midline.

==============================================================
DELIVERABLES (STL FILES)
==============================================================
Monkey (Wall V1.1):
   1. head.stl
   2. eye_board.stl
   3. muzzle.stl
   4. torso_front.stl
   5. torso_back.stl
   6. bottom_plate.stl
   7. upper_arm_left.stl
   8. upper_arm_right.stl
   9. forearm_left.stl
  10. forearm_right.stl
  11. leg_left.stl
  12. leg_right.stl
  13. yoke.stl
  14. servo_bracket.stl

External Hub:
  15. hub_box.stl
  16. hub_lid.stl

All 16 STL files must be manifold, watertight, and ready for
direct slicing in Bambu Studio / PrusaSlicer. Target total
filament: ~58 g across all parts. Target total print time on a
Bambu X1C: ~6 hours.

==============================================================
THE GESTURE — VISUAL TARGET
==============================================================
The single image that pitches this product: the monkey is caught
mid-gesture with both hands cupped gently over its own mouth
(over the walnut muzzle insert), covering the entire lower half of
the face from just below the eye-board down to the chin. The eyes
remain fully visible ABOVE the cupped hands. Elbows are held
slightly forward of the shoulders, never flared out sideways. The
pose reads with calm dignity, never cartoonish. The hands meet
softly at the center of the face — a wordless "shh."

The static design at rest must visibly anticipate this motion:
arms hang slightly forward of the body (5° forward of hip line),
hands' palm-cups subtly angled inward toward the body, eyes
attentive. The form is "patient, watching, ready."

This is not a toy. This is a designed object.
```

---

## Usage notes

1. Copy the entire fenced block above and paste into cad.atech.dev.
2. If the tool offers a reference image input, also upload [renders/frame-4-peak-20260523-144536.png](renders/frame-4-peak-20260523-144536.png) — that's the validated visual target.
3. The tool may return individual STLs or a single GLB — both work for slicing. If GLB, convert to STL via [renders/mesh.py](renders/mesh.py) or Blender.
4. Drop the resulting STLs into [`stl/wall/`](../stl/wall/) and [`stl/hub/`](../stl/hub/) to replace the existing OpenSCAD-generated ones if cad.atech.dev produces better geometry.

## Reference image

[frame-4-peak-20260523-144536.png](renders/frame-4-peak-20260523-144536.png) — the approved hand-over-mouth peak pose. Upload this as visual reference if cad.atech.dev supports image conditioning.

## Existing CAD as fallback

If cad.atech.dev results are weaker than the OpenSCAD baseline:
- [../cad/monkey-wall.scad](../cad/monkey-wall.scad) — full parametric source
- [../cad/hub.scad](../cad/hub.scad) — hub source
- Both already produce 16 watertight STLs ready for print
