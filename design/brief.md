# Monkey — Industrial Design Brief (V1)

> **Codename:** *Tys-aben* ("the shush monkey") — a Scandinavian-design office object that covers its own mouth when the room gets too loud. Iwazaru ("speak no evil") adapted as a silent social signal: when the monkey shushes itself, it's telling the room to do the same.

---

## 0. Design north star

Kay Bojesen's 1951 teak monkey is the reference. Bojesen's mantra was **"the line should smile"** — every curve should feel warm, never sharp or industrial. The original is 31 hand-glued parts in teak and limba, with limbs strung on an internal elastic so they can be posed by hand. Black-bead eyes, a small glued-on muzzle, no painted features.

We are **not cloning Bojesen.** This is a tribute that earns its own form by adding one thing Bojesen's never did: it *moves on its own.* The motion has to feel as warm and considered as the silhouette — anything that looks like a Halloween animatronic kills the whole object.

### Three design rules (apply to every decision below)

1. **The line should smile.** No straight edges, no sharp fillets. Every transition is a radius. If a profile looks "engineered," reshape it.
2. **Hide the machine.** No visible screws, no exposed cables, no servo horns peeking out. The seam between halves should read as an intentional joint, not an assembly artifact.
3. **Motion as gesture, not animation.** One slow, considered movement — hands rise to cup the mouth over ~1.2s with an ease-in/ease-out curve. The eyes remain visible above the cupped hands — eye-contact is preserved throughout, which is what makes the "shh" land. Holds for the duration of the noise event. Lowers even slower (~1.8s) as if reluctant to release. No twitching, no servo buzz, no return-to-zero snap.

---

## 1. Form & proportions

**Overall height:** 220 mm (matches Bojesen "small" at 200 mm but slightly taller to accommodate the internal mechanism without compromising silhouette).

**Stance:** Seated, legs forward and slightly apart, hands resting on thighs at idle. Seated (rather than standing) gives a stable base, hides the speaker/electronics in the lower body, and reads as a desk companion rather than a toy on a shelf.

### Proportions (head-to-toe)

| Element | Height | Notes |
|---|---|---|
| Head | 70 mm | ~32% of total — slightly oversized vs. naturalistic, in Bojesen tradition. Pure sphere with a flat-cut chin, no neck. |
| Torso | 80 mm | Barrel-shaped, widest at the chest, tapering to the hips. Houses the servo + ESP32. |
| Legs (seated) | 70 mm | Folded forward. Feet act as front anchors of the base. |
| Arm length | 135 mm (~60% of total height) | Bojesen-signature long arms — easily reach the mouth when raised (shorter travel than reaching the eyes, so kinematics is forgiving). Two joints (shoulder + elbow), Bojesen-style visible pin joints. |

### Silhouette principles

- **Head:** A near-perfect sphere. The face is a shallow ovoid recess (~3mm deep) on the front, with three glued/printed inserts: a darker "eye-board" (horizontal lozenge) and a small round muzzle below. Eyes are two 6mm black hemispheres pressed in — true to Bojesen's black-bead eyes.
- **Ears:** Small, flush, almost vestigial — two shallow discs on the sides of the head. Bojesen's monkey reads as a monkey from the silhouette and proportions, not from cartoon ears.
- **Torso:** Egg-section, broader at the shoulders. The two halves split along a curved seam that follows the spine + belly midline, so the seam reads as a body contour, not a part line.
- **Limbs:** Cylindrical with subtle taper toward the joints, exactly like Bojesen. Each limb is a single printed piece. No surface detail — the wood-grain finish does the work.
- **Joints:** Visible pin joints at shoulder, elbow, hip, knee. **Only the shoulders are functional** (driven by the internal servo via tendons). The elbow joint is sculpted in but rigid — the arm is one piece with a "joint" detail at the elbow that exists purely for the Bojesen visual signature.

### What we deliberately reject

- Cartoon faces, painted smiles, painted nostrils.
- Visible logos, brand marks, or text on the body.
- Tail. (Bojesen's monkey has none. A tail also fights with the seated stance and the rear electronics access panel.)
- Any "tech" reveal — no visible LED, no status indicator. If we need a debug light, it lives inside the battery compartment.

---

## 2. Mechanism

### Concept: tendon-driven shoulders, single servo

A single SG90-class micro servo lives vertically inside the torso, centered on the spine axis. Its horn drives a small yoke. Two non-stretch braided fishing lines (the "tendons") run from the yoke up and out through low-friction PTFE-lined channels printed into the torso, exit at the shoulder pin axis, and terminate inside each upper arm just behind the shoulder joint.

When the servo rotates upward, both tendons shorten symmetrically, rotating both arms about the shoulder pins so the hands sweep upward and inward to cup the mouth (the walnut muzzle area). The travel is shorter than reaching the eyes would be, which means less tendon tension, less servo strain, and a more reliable hold at peak. A pair of light return springs (or a single elastic band routed across the chest, Bojesen-style) pulls the arms back down to the resting position when the servo releases.

### Why this approach

- **One motor, perfectly symmetric** — no possibility of one arm leading the other. Cheaper and more reliable than two servos.
- **No external linkages** — the only moving thing visible from outside is the arms themselves.
- **Servo is silent at hold** — once arms are up, the servo is at the end of its travel against soft springs, not actively driving. Eliminates buzz.
- **Bojesen-honest** — the original uses internal elastic to articulate limbs. Tendons + return spring is the same principle, mechanized.
- **Failure mode is graceful** — if the servo dies or power is lost, the springs pull the arms back to the resting pose. The monkey returns to "calm."

### Motion profile (firmware-side)

- **Trigger:** ambient noise above threshold for ≥800 ms (avoids reacting to single claps).
- **Raise:** servo ramps from 0° to 90° over 1.2 s with a cosine ease (no linear motion — linear servo motion is the #1 thing that makes hobby projects feel cheap).
- **Hold:** stays covered as long as noise stays above (threshold − 6dB hysteresis), with a minimum hold of 4 s so it doesn't flicker on the edge.
- **Lower:** ramps back down over 1.8 s, also eased.
- **Cooldown:** 8 s minimum between triggers. The monkey is not a meter; it's a gentle social signal.

---

## 3. Print strategy

### Parts breakdown (target: 9 printed parts)

1. **Head** — single piece, printed upside-down (chin to bed) to put support on the flat chin cut and keep the spherical surface clean.
2. **Eye-board insert** — small, separate, printed in the darker (teak) filament. Press-fit into the face recess.
3. **Muzzle insert** — same as eye-board, darker filament.
4. **Torso front half** — split along the curved spine seam. Cavity for ESP32, mic, and servo mount. Mic port is a 3mm hole hidden behind the eye-board insert (sound travels up the neck cavity to the mic).
5. **Torso back half** — same seam. Includes a magnetically-retained access panel (~40×60 mm) at the lower back for USB-C and reset access.
6. **Left arm** — single piece, printed lying flat with the inner (body-facing) side down. Tendon channel printed in.
7. **Right arm** — mirror of left.
8. **Left leg** — single piece, posed seated.
9. **Right leg** — mirror.

### Filament & finish

- **Body / head / limbs:** light wood-fill PLA (limba reference) — e.g. ColorFabb WoodFill or Polymaker PolyWood "natural."
- **Eye-board / muzzle / hands (last 20mm of each arm):** dark wood-fill PLA (teak reference) — ColorFabb WoodFill "darker" or aged with linseed.
- **Eyes:** 6 mm black glass beads or black-painted resin hemispheres, press-fit into 5.8 mm holes in the eye-board. Real beads beat any printed approximation.

### Post-processing (this is where the Bojesen-quality bar is met or missed)

1. Print at **0.12 mm layer height** for body and head, 0.16 mm acceptable for limbs.
2. Sand progressively: 240 → 400 → 600 grit. Wood-fill PLA sands beautifully and exposes more wood fiber.
3. Apply **food-safe boiled linseed oil** (or Osmo Polyx) with a lint-free cloth. Two coats, 24h apart. This is the single biggest jump in perceived quality — it transforms wood-fill PLA from "3D print" to "actual wood object."
4. Buff with a soft cloth between coats.

### Print orientation cheat sheet

| Part | Orientation | Supports |
|---|---|---|
| Head | Chin down | None (sphere prints clean from a small flat) |
| Torso halves | Seam side down | Tree supports inside cavity only |
| Arms | Inner side down | None |
| Legs | Inner side down | None |
| Eye-board / muzzle | Flat face down | None |

---

## 4. Internal layout (torso cavity)

```
       ┌─── neck cavity (mic sound path) ───┐
       │                                    │
   ┌───┴────────────────────────────────────┴───┐
   │  [I2S mic, pointed up neck]                │  ← chest level
   │  [ESP32-S3 dev board, vertical, USB down]  │
   │  ┌──────────────────────────────────────┐  │
   │  │           SG90 servo                 │  │  ← center
   │  │  (shaft vertical, yoke at top)       │  │
   │  └──────────────────────────────────────┘  │
   │  [tendon yoke] ─→ tendons up to shoulders  │
   │                                            │
   │  [USB-C breakout, accessible via back hatch]│  ← hip level
   └─────────────────────────────────────────────┘
```

- Mic at the top of the cavity, pointed up the neck — the neck channel acts as a short waveguide, and the eye-board hole on the face is the actual sound port. Hides the mic completely while keeping it acoustically open.
- ESP32 mounted vertically against the inside of the torso back half.
- Servo cradled in printed-in ribs in the front half.
- All wiring runs along channels in the back half; no loose cables.

---

## 5. The "Scandi quality" checklist

Before signing off any prototype, it must pass all of these:

- [ ] **Silhouette test:** photograph as black silhouette against white. Should be unmistakably a monkey, unmistakably Bojesen-adjacent, with no part lines visible.
- [ ] **Hand-feel test:** pick it up. The weight should feel right (target ~250 g — heavy enough to feel solid, light enough to handle). Edges should be sanded to where no seam is felt with closed eyes.
- [ ] **Idle test:** sit it on a desk for an hour while powered on. It should be completely silent. No fan noise, no servo hum, no LED visible.
- [ ] **Gesture test:** trigger it ten times. Every motion should feel identical, slow, and intentional. Anyone watching should say "oh, it's shushing us," not "oh, a robot moved." The eyes should remain fixed on the viewer during the held pose — that's the social-signal moment.
- [ ] **Aged-friend test:** hand it to someone who doesn't know what it does. They should want to pick it up. If their first reaction is "what does it do?" instead of "oh, hello" — the form has failed.

---

## 6. Out of scope for the ID work (kept simple on purpose)

- Battery / charging dock — V1 is USB-C powered, full stop.
- Tail, fingers, separated thumb — Bojesen had none of these; we won't either.
- Multiple SKUs / sizes — single 220 mm size for V1.
- Custom PCB — V1 uses off-the-shelf ESP32-S3 dev board.
- Painted finishes — wood-fill + oil only. If we want color in V2, we'll do dyed oil, not paint.

---

## 7. Open questions for the next iteration

- **Spring vs. elastic return:** two coil springs (cleaner force curve) vs. one woven elastic band routed Bojesen-style across the chest behind the arms (more honest tribute). Need a physical prototype to decide.
- **Eye-board geometry:** horizontal lozenge (Bojesen) vs. a softer rounded rectangle. Bojesen wins on tribute, but the rounded version may print cleaner.
- **Hand shape:** Bojesen's hands are simple cylindrical stubs. Should we leave them as stubs (honest), or sculpt a shallow palm-cup so they nest gently over the muzzle when raised? The cup is more "expressive" but starts to feel cartoonish. Working assumption: shallow palm-cup with inward wrist tilt — locked in [image-spec.md](image-spec.md).
- **Sound:** speaker yes/no in V1.1? If yes, where does the grille go without breaking the silhouette? (Candidate: hidden in the seated-pose space between the thighs, firing downward into the desk for a soft diffused sound.)
