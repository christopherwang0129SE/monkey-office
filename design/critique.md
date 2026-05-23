# Design Critique — Aben V0.2

> An honest assessment of where the current design sits and what it would take to move it from "smukt 3D-print" to **generationelt skandinavisk design** — Bojesen, Wegner, Jacobsen, Henningsen, Mogensen niveau.

---

## What V0.2 actually is right now

A competent, organically-shaped, 3D-print-ready figurine with:
- Smooth surfaces (no hard primitive cuts left)
- Recognizable monkey silhouette
- Functional internal mechanism
- Clean assembly path

That puts it firmly above "hobby 3D print" but **well short** of generational design. The gap is real and worth naming.

---

## Why it isn't there yet

Looking at the front render with cold eyes, six things keep it from feeling like a Bojesen-tier object:

### 1. The form has no intentionality

It looks *made* (parametrically generated, smoothed, exported) rather than *designed* (a series of considered decisions left visible as character). Bojesen's monkey, Wegner's Y-chair, Jacobsen's Egg — every line in those objects feels like someone *chose it over alternatives*. Ours feels like it fell out of `hull()`.

**What's missing:** moments where a designer "leaves a fingerprint" — a slight asymmetry, a deliberate plane, a curve that doesn't *need* to be there but is.

### 2. Body parts are clip-on, not integrated

The arms emerge from the torso at a hard right angle, like sausages bolted to a barrel. Wegner spent his career on *how a leg meets a seat* — the joint is the design. Our shoulder is just where the cylinder happens to intersect the egg.

**What's missing:** a flowing shoulder. The torso should *swell* outward into the arm, the arm should *grow* out of the torso. Use `hull()` from torso shoulder bosses *into* the arm root — one continuous form, no visible join.

### 3. The hands are spheres

The hands are the **active element** of this product. They are what moves. They are what tells the story. And we've rendered them as plain bulbs at the end of the arm.

Bojesen's monkey hands are shaped objects — they have a slight curl, a directionality, you can tell which way the palm faces. Ours can't tell you anything.

**What's missing:** a *cup* in each hand. Hollow out a shallow indent on the palm-facing side. Tilt the wrist slightly so the palm angles inward. When the gesture happens, the hands meet the face like *cupped palms*, not like clubs.

### 4. The face is blank without the inserts

The eye-board and muzzle are *jewellery* — they should sit on top of a face that already has character. Currently, remove the inserts and you have a smooth sphere with two slight ears. No brow. No cheek planes. No defined chin. Nothing for light to catch on.

A generational designer composes the face *first*, then adds inserts as accent. We did it backward.

**What's missing:** sculpted brow ridge above the eye-board recess. Shallow cheek planes flanking the muzzle. A defined chin (subtle plane, not flat cut). These give the face its skeleton — the inserts are then *clothing* on a face that already exists.

### 5. The pose is the wrong story

Seated with legs splayed forward = "mid-shrug." It tells no story. Standing with long arms hanging at the sides = the iconic Bojesen story: *patient, watching, ready*. The eye-cover gesture lands harder from a standing patient pose than from a seated splay.

**What's missing:** stand it up. Lengthen the legs. Reposition the feet for a stable wide base, slightly toed-out (~10°) for charm. Arms hang long at the sides.

### 6. The proportions are off

Bojesen "small" (200mm tall) breakdown:
- Head ≈ 31% of height
- Torso ≈ 37%
- Legs (standing) ≈ 35%
- **Arms ≈ 62% of total height** ← the signature

Our V0.2:
- Head ≈ 33% ✓
- Torso ≈ 36% ✓
- Legs ≈ 35% (folded for seated) ✓
- **Arms ≈ 50%** ← too short by ~25mm

Long arms is THE Bojesen visual signature. Without them we don't read as a Bojesen-tribute — we read as a generic figurine.

**What's missing:** arms from 110mm to ~135mm (60% of total height).

### 7. The tech is visible

A back hatch. A USB-C cutout. Magnet pockets. These are *engineering admissions*. A generational object hides its engineering completely.

Verner Panton's chair is fiberglass — but you see no mold seams. Bojesen's monkey has 31 internal parts strung on elastic — but you see only wood and grace. Henningsen's PH lamp shows engineering, but as *the design itself*, not as a service hatch.

**What's missing:** move all access to a removable **wooden base disc** that the monkey stands on. USB-C threads through a notch in the disc edge. Servicing happens by lifting the monkey off its base. The disc IS the cable manager AND the access panel. The body itself becomes a single sealed sculptural object.

---

## What "the smile in the line" actually means (mechanically)

Bojesen said *"linjen skal smile."* In practical design terms this means: at every curve, ask whether the curve direction subtly arcs *upward* relative to the gaze of someone holding the object.

Specific places this applies for Aben:

| Curve | Current direction | Should be |
|---|---|---|
| Chin → neck | Symmetric drop | Slight forward-and-up lift before going down |
| Shoulder | Right-angle | Soft uplift before the arm descends |
| Elbow | Just narrower | Slight upward bulge before tapering forearm |
| Foot | Forward bulb | Forward-and-slightly-up tip (like a slipper toe) |
| Eye-board lozenge | Horizontal flat | Faint downward bow at the centre (like a smile, or a worried brow — both work because they suggest *expression*) |

These are 2-3mm decisions. But they're the difference between a curve that *exists* and a curve that *means something*.

---

## The single most important shift

If you do only one thing: **honor the moment of motion as the entire reason the object exists.**

Right now the static form and the motion are two separate things. The form is a figurine, the motion is a feature.

Generational version: the static form is *visibly waiting for the motion*. The hands at rest are subtly poised — not flopping, but ready. The eyes at rest look outward, attentive. When the motion happens, it's the only thing that matters, and the form has been quietly preparing you for it from the moment you put the object on your desk.

This isn't a CAD change. It's a *posture* change. Specifically:

- Hands at rest: slight forward angle (~15° toward chest), palms turned subtly inward — "ready to lift."
- Arms hang slightly forward of the body, not at the sides — "alert, not relaxed."
- Eyes positioned slightly *above* the muzzle (not at centre of face) — the gaze is forward, not downward — "watching."

These three details cost almost nothing in CAD time but change the product's emotional reading completely.

---

## Prioritized moves (ranked by impact-per-effort)

| # | Move | Effort | Impact |
|---|---|---|---|
| 1 | **Stand the monkey up** — legs straight, feet stable | small | huge — fixes the awkward pose, enables long-arm signature |
| 2 | **Arms to 135mm** (60% of height) | trivial parameter change | huge — Bojesen signature |
| 3 | **Flowing shoulder** — `hull()` torso-to-arm-root, no clip-on look | medium | huge — kills the "assembled from parts" feeling |
| 4 | **Sculpted hands** — palm cup, wrist tilt | medium | high — gives the gesture meaning |
| 5 | **Sculpted face** — brow, cheek planes, chin | medium | high — face reads even without inserts |
| 6 | **Wooden base disc** — hides USB, eliminates back hatch | medium | high — removes all "tech reveal" |
| 7 | **"Alert" rest posture** — hands forward, arms slightly off body | trivial | high — emotional intentionality |
| 8 | **"Smile in the line" curve tuning** — chin, shoulder, elbow, foot, eye-board | medium | medium — the difference between competent and beloved |
| 9 | **Invisible seam** — sand flush, wood-filler at the gap | post-print | medium — finishing-stage |
| 10 | **2-piece elastic arms** — for honest hand-to-face landing | high | medium — only matters if rigid arm reach proves wrong |

---

## What this is NOT asking for

- A bigger BOM
- More electronics
- More features
- A bigger object

Generational Scandinavian design **subtracts**. It removes the back hatch, removes the visible USB, removes the cartoon ears, removes the clip-on shoulders. What remains is fewer parts, fewer compromises, and one strong gesture.

The path forward is *less* — but more carefully chosen.

---

## Concrete next-step proposal (V0.3)

If we do just moves **1, 2, 3, 6, 7** above:
- Stand it up
- Arms 135mm
- Flowing shoulder via hull
- Wooden base disc (no back hatch, no rear USB)
- Alert rest posture

…that's 5 changes, all parametric, no new mechanism complexity. Result is a meaningfully more Bojesen-tier silhouette without growing scope.

Moves 4, 5, 7 (hand-sculpt, face-sculpt, curve-tuning) raise the ceiling further but want human sculpting time in Blender — they're V1.0 work, not V0.3.

Move 10 (2-piece arms) only matters if a printed V0.3 proves the gesture doesn't land. Defer until physical prototype.
