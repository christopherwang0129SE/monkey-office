# ASSEMBLY.md — Tys-aben Wall V1.1

Step-by-step physical assembly of the wall-mounted Tys-aben + external hub.

## What you need

### Printed (15 parts)
From [`../stl/wall/`](../stl/wall/):
- `head.stl`
- `eye_board.stl`
- `muzzle.stl`
- `torso_front.stl`
- `torso_back.stl`
- `bottom_plate.stl`
- `leg_left.stl`, `leg_right.stl`
- `upper_arm_left.stl`, `upper_arm_right.stl`
- `forearm_left.stl`, `forearm_right.stl`
- `yoke.stl`
- `servo_bracket.stl`
- `mic_bracket.stl`

From [`../stl/hub/`](../stl/hub/):
- `hub_box.stl`
- `hub_lid.stl`

### Electronics (you already have)
- Motherboard (60 × 7 × 120 mm) — lives in hub
- I2S microphone (40 × 11 × 20 mm) — lives in monkey torso
- USB-C breakout (20 × 10 × 20 mm) — lives in hub rear wall
- SG90 micro servo — to be purchased ($2)

### Mechanical hardware
| Item | Qty | Note |
|---|---|---|
| 5 × 2 mm neodymium magnets | 5 | 4 for hub lid + 1 for bottom plate |
| 3 mm steel pins, 40 mm long | 2 | shoulder pivots |
| 2 mm steel pins, 15 mm long | 2 | elbow hinges (paperclip works) |
| Braided fishing line | 60 cm | tendons |
| Sewing elastic, 1.5 mm | 10 cm | forearm-return spring |
| Wall screws | 3 | 1 for monkey keyhole, 2 for hub |
| 4-conductor wire | ~30 cm | mic I2S cable to hub |
| 3-conductor wire | ~30 cm | servo control to hub |

### Tools
- Soldering iron
- Small Phillips screwdriver
- Sandpaper 240 / 400 / 600 grit
- Boiled linseed oil OR Osmo Polyx
- Lint-free cloth

---

## Phase 1 — Surface finish (~1 hour active, 48 h cure)

This is what makes the print look like wood instead of plastic.

1. **Sand all visible parts** (head, torso halves, limbs, hub):
   - 240 grit first, sanding along the layer direction
   - then 400 grit
   - then 600 grit
2. **Wipe clean** with a damp cloth, let dry fully.
3. **Apply linseed oil**: thin coat with lint-free cloth.
4. Wait 24 h.
5. Buff with soft cloth, apply second coat.
6. Wait 24 h.
7. Buff to satin sheen.

Skip this and you have a competent prototype. Do this and you have
something you'd actually keep on a wall.

---

## Phase 2 — Sub-assemblies

### 2a. Hub interior
1. Solder USB-C breakout into the rear-wall cutout of `hub_box`.
   USB-C port faces outward.
2. Place motherboard flat in the bottom of the hub between the
   4 printed locator pegs. Loose-fit; gravity holds it.
3. Solder a 3-conductor wire (red, white, brown) from the motherboard's
   servo-control GPIO + 5V + GND to a 3-pin female header. Route the
   wire bundle up through the top cable inlet.
4. Solder a 4-conductor wire (VCC, GND, BCLK, LRCL, DOUT — actually
   5 conductors) from the motherboard's I2S pins. Same routing,
   up through the top cable inlet.
5. Push the 4 neodymium magnets into the lid-pockets on the hub_box's
   top rim. Press-fit only — no glue.
6. Set the hub_lid aside for final close-up.

### 2b. Servo + yoke + tendons
1. Press the `yoke.stl` onto the SG90 servo horn — friction fit, no glue
   yet (you may want to remove the horn to adjust angle later).
2. Tie a length of fishing line to one yoke arm. Set this aside —
   you'll route it through the torso next.

### 2c. Two-piece arm sub-assembly (do this for BOTH sides)

The key mechanism. Take your time.

1. **Route the tendon through upper_arm**: thread the free end of
   the fishing line into the bottom of `upper_arm_left.stl` (the
   shoulder ball end), feed it through the internal tendon channel,
   and pull it out at the elbow's front-face exit hole.
2. **Cross the elbow joint**: pull the tendon across the elbow gap
   into the tendon entry of `forearm_left.stl` (proximal end).
   Feed it down through the forearm's internal channel until it
   exits in the knot pocket.
3. **Tie a knot**: anchor the tendon with a secure knot inside the
   knot pocket. Trim the excess. The knot must be larger than the
   2 mm tendon channel so it can't pull back through.
4. **Pin the elbow**: slide the 2 mm steel pin (15 mm length) through
   the upper_arm's elbow knuckle and the forearm's proximal end.
   The forearm should swing freely on this pin.
5. **Install the return elastic**: thread a 10 cm length of 1.5 mm
   sewing elastic through the back-side anchor holes — through
   `upper_arm`'s back hole, across the back of the elbow joint,
   through `forearm`'s back hole. Pull just snug (not stretched)
   when the arm is straight. Tie off with a small knot at each end.
   This elastic pulls the forearm back to "straight" when the servo
   releases tendon tension.
6. **Repeat** for the right arm.

### 2d. Mic in bracket
1. Slide the mic board into the `mic_bracket.stl` — friction fit.
   The MEMS port (small hole on the mic chip) must face UP toward
   the bracket's sound-port hole.
2. Route the I2S wire from the mic out the wire passage at the
   bottom of the bracket.
3. Solder the wire to a 5-pin female header (or whatever connector
   matches the hub's I2S cable).

---

## Phase 3 — Body assembly

### 3a. Drop electronics into torso
1. Place the `servo_bracket.stl` inside the `torso_front.stl` half.
   It snaps into the printed ribs.
2. Drop the servo + yoke assembly into the bracket. Servo shaft
   points UP.
3. Slide `mic_bracket.stl` (with mic) into the upper section of the
   torso cavity. MEMS port faces up into the neck.
4. Route both tendons (from servo yoke arms) up the inside of the
   torso cavity and out through the shoulder pin holes — one to each
   side. Each tendon emerges through the inside of the upper_arm.
5. Bundle the mic + servo wires together. Route them down through
   the bottom of the torso (you'll thread them through the bottom
   plate next).

### 3b. Attach arms at shoulders
1. From OUTSIDE the torso, slide a 3 mm steel pin (40 mm length)
   through the upper_arm_left shoulder ball, through the torso's
   shoulder hole, and out the other side. The arm rotates around
   this pin.
2. Repeat for the right arm.
3. With the tendon coming from inside the torso through the shoulder
   pin axis, tie it off to the upper_arm's anchor inside the arm
   (use a small knot in the tendon channel).
4. Verify both arms hang freely at rest.

### 3c. Close the torso
1. Match `torso_back.stl` to `torso_front.stl` along the curved
   spine seam.
2. Apply a small bead of wood-glue along the seam (optional —
   friction-fit can be enough if your printer's tolerances are tight).
3. Press together. Wipe off any squeezed-out glue immediately.
4. Hold with rubber bands or clamps for 30 minutes.

### 3d. Attach head + face inserts
1. Press `head.stl` onto the torso's neck socket. Friction-fit
   first, then CA glue if you want it permanent.
2. Press the 2 black glass beads (6 mm) into the eye-board's eye
   holes. They should snap in.
3. Press-fit `eye_board.stl` into the upper face recess. The faint
   smile-line bow at center should be roughly aligned horizontally.
4. Press-fit `muzzle.stl` into the lower face recess just below
   the eye-board.

### 3e. Attach legs
1. Press `leg_left.stl` and `leg_right.stl` into the hip sockets.
   They should dangle freely — they're passive, not functional.

### 3f. Close the bottom
1. Route the wire bundle (mic + servo cables) through the 14 × 8 mm
   cable cutout in `bottom_plate.stl`.
2. Press the 5 × 2 mm neodymium magnet into the bottom_plate's
   magnet pocket (match polarity with the corresponding magnet
   already pressed into the torso's lower interior).
3. Snap the bottom_plate to the torso. It should hold magnetically.

---

## Phase 4 — Wall mounting

### 4a. Mount the monkey
1. Locate the wall position: eye-level for the typical seated person
   (~1.4 m from floor), centered on the area you want to monitor.
2. Drill a single hole, drive a screw with the head left protruding
   ~3 mm from the wall.
3. Hang the monkey on the screw via the keyhole on the torso's back.
   It should snap securely into place.

### 4b. Mount the hub
1. Position the hub ~5–10 cm below the monkey, so the cable bundle
   runs cleanly downward.
2. Drill 2 holes matching the hub's back-wall screw holes (24 mm
   apart, 4.5 mm diameter).
3. Drive the screws through the hub and into the wall.

### 4c. Connect cables
1. Plug the mic + servo wire bundle from the monkey into the
   matching connectors on the motherboard inside the hub.
2. Close the hub: place `hub_lid.stl` onto the hub_box. The 4
   magnets snap it shut.
3. Plug a USB-C cable into the hub's external port → wall outlet.

---

## Phase 5 — Firmware + tuning

See [`../firmware/README.md`](../firmware/README.md).

1. Connect a USB-C cable from the motherboard to your computer.
2. Upload [`../firmware/tys-aben.ino`](../firmware/tys-aben.ino).
3. Open Serial Monitor at 115200 baud.
4. Tune `THRESHOLD_DB` based on your room's baseline.
5. Tune `SERVO_REST_US` and `SERVO_PEAK_US` so the arms hang
   correctly at rest and the hands cup the mouth at peak.

The first power-on may need 5–10 minutes of trial-and-error tuning.
After that the monkey is a finished installation.

---

## Troubleshooting

| Symptom | Cause | Fix |
|---|---|---|
| Arms don't return to rest | Elastic too loose | Re-tie with more tension |
| Arms jam mid-motion | Forearm catches on upper-arm | File down the elbow clearance slot |
| Hands miss the mouth | Tendon length wrong | Adjust knot position in forearm pocket |
| Servo buzzes constantly at hold | Servo fighting against a hard stop | Lower `SERVO_PEAK_US` by 50 µs at a time |
| Mic doesn't respond | I2S wires swapped | Double-check BCLK/LRCL/DOUT mapping |
| Mic reads constant noise | Mic GND not connected | Verify continuity from mic GND to MCU GND |
| Monkey falls off wall | Screw too small | Use ≥ 4 mm screw with proper anchor |

---

## What "fully working" looks like

When everything's right, you should see:

1. Sit in a quiet room → Serial reads ~30–40 dB-ish, monkey idle.
2. Talk normally near the mic → dB rises to ~55, monkey still idle
   (below threshold).
3. Two people talk loudly at the same time → dB hits 65+, after
   800 ms the monkey's arms slowly rise (1.2 s) and cup the mouth.
4. People notice → quiet down → after 4 s minimum hold and noise
   drops below 59 dB (hysteresis), monkey lowers arms over 1.8 s.
5. 8 s cooldown — monkey won't re-trigger immediately.

That's the social signal loop.
