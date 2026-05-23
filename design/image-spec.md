# Image-spec — Aben

> Komplet specifikation til GPT Image 2 (gpt-image-1). Mål: én låst visuel kanon vi kan generere konsistent som **pitch-animation** og **CAD-reference**, før vi laver 3D-modellen.

---

## Sådan bruges filen

1. Hver prompt nedenfor er **paste-ready** — kopier hele blokken (inkl. Master DNA) ind i GPT Image 2.
2. Generér **Hero** først. Det låser udseendet.
3. Brug Hero som **image-reference** (drag & drop) i alle efterfølgende prompter for at maksimere objekt-konsistens.
4. Format: kvadrat 1024×1024 til Hero og story arc. Til CAD-reference views (front/side/back/top): brug også kvadrat, eller 16:9 hvis modellen tillader.
5. Når en variant rammer perfekt, opdater Master DNA hvis detaljen blev finpudset.

---

## Master DNA

Den her tekst skal være IDENTISK i hver prompt. Det er det som binder serien sammen som ét objekt.

```
SUBJECT
A small wooden monkey figurine, 22 cm tall, photographed as a fine
Scandinavian product object in the tradition of Kay Bojesen's 1951
teak monkey — a fresh 2026 piece, not a replica.

MATERIAL
- Body, head, arms, legs: light birch wood, visible fine vertical
  grain, satin oiled finish, warm honey hue.
- Eye-board insert (horizontal lozenge ~32 × 12 mm, with a faint
  downward bow at center like a soft smile-line) and muzzle insert
  (small round, ~10 mm): darker walnut wood, same satin finish,
  sitting slightly proud of the face like inlay.
- Eyes: two 6 mm black glass beads, deep matte black, set into the
  eye-board with a clean soft shadow ring.
- Base disc the figure stands on: medium-tone maple, 120 mm diameter,
  10 mm thick, soft chamfered edge.
- No paint, no plastic sheen, no glossy lacquer, no print lines.

PROPORTIONS
- Head: near-perfect sphere, ~70 mm, ~32% of total height. Chin is a
  softly rounded plane (not flat-cut). No neck. Two flush vestigial
  ear-discs barely perceptible from the front.
- Face: shallow ovoid recess on the front. Walnut eye-board sits in
  the upper half, walnut muzzle sits below it. No mouth, no nostrils.
  A subtle brow ridge above the eye-board and shallow cheek planes
  flanking the muzzle give the face structure.
- Torso: egg-shaped, broadest at shoulders, tapering to hips, ~80 mm.
  Front/back seam follows the spine-and-belly midline and reads as a
  body contour, not an assembly line.
- Shoulders: flowing into the torso — the torso swells outward and
  the arm grows from it as one continuous form. No clip-on look.
- Arms: very long at 135 mm — roughly 60% of total height.
  Cylindrical with subtle taper toward the wrist. Sculptural pin
  joint visible at the shoulder; a sculpted elbow detail.
- Hands: shallow palm-cup with inward wrist tilt — palms angle
  subtly toward the body, ready to lift.
- Legs: straight, standing, ~70 mm visible. Feet slightly toed-out
  (~10°). Toe tips lift forward-and-slightly-up like slipper toes.

POSTURE & PRESENCE
- Stance: patient, watching, ready. Never slumped, never robotic.
- At rest the arms hang ~5° forward of the hip line — alert, not
  relaxed. Eyes always forward, attentive.

STYLE & LIGHT
- Scandinavian product photography. Soft northern daylight from
  upper-left. Neutral warm-white seamless paper backdrop. Single
  soft shadow pooling under the base disc. Slight film grain.
- The object reads as something a museum gift shop would sell —
  never as a 3D print, never as CGI.

THE LINE SHOULD SMILE
Every transition is a radius. No sharp fillets, no right angles.
At chin, shoulder, elbow, foot tip and eye-board: the curve arcs
subtly UPWARD relative to the viewer's gaze — the Bojesen rule,
"linjen skal smile."

NEVER VISIBLE
No screws, no USB port, no LED, no cables, no servo, no metal
fittings, no logo, no text, no painted features, no cartoon eyes,
no mouth, no nostrils, no separated fingers, no tail, no toy
aesthetic, no Halloween animatronic look, no robot.
```

---

# SECTION A — Story arc (pitch-animation)

> 5 sekventielle frames + 1 hero shot. Hver frame har SAMME kamera-position, SAMME baggrund, SAMME lyssætning, SAMME objektplacering — kun aben bevæger sig.

## Hero shot

```
[PASTE MASTER DNA HERE]

THIS SHOT — HERO
Editorial product hero. Three-quarter front view, slight rotation to
camera-left so we see depth on the right shoulder and the long right
arm. Camera at the monkey's chest height. 85 mm equivalent lens, no
distortion, shallow depth of field with the face in critical focus
and the base disc gently softened. The arms hang along the sides
at rest, hands at hip level, palm-cups subtly angled inward. Eyes
forward, attentive. The figure fills the vertical frame with
comfortable headroom; the base disc reads as a sculptural stage
beneath it. Empty warm-white backdrop. This is the catalogue cover.

ASPECT
1:1
```

## Frame 1 — Idle (the room is quiet)

```
[PASTE MASTER DNA HERE]

THIS FRAME — IDLE
The monkey stands on its base disc on a light maple desk surface,
photographed at desk-height in a tight three-quarter view. The arms
hang fully along the sides at the resting angle (~5° forward of the
hips). Hands at hip level, palm-cups angled subtly inward. Eyes
forward, attentive. Out-of-focus warm interior bokeh implies an
office in the background — no people visible. The composition is
calm and still.

NARRATIVE BEAT
The opening shot. The room is quiet. The monkey is patient.

ASPECT
1:1
```

## Frame 2 — First lift (the gesture begins)

```
[PASTE MASTER DNA HERE]

THIS FRAME — FIRST LIFT
Identical camera, identical background, identical lighting to Frame 1.
The arms have just begun to rise. Elbows are still low, close to the
torso. The forearms have rotated upward and inward by perhaps 20
degrees — hands are now at mid-chest height, palms turning to face
the lower part of the face (the muzzle / mouth area). The shoulders
show their flowing transition into the torso as the geometry shifts.
The gesture is slow and deliberate, caught at the very start of the
motion. Eyes still forward, attentive.

NARRATIVE BEAT
Something has changed in the room. The motion has begun — a quiet
"shh" is on its way.

ASPECT
1:1
```

## Frame 3 — Mid-arc (halfway to the mouth)

```
[PASTE MASTER DNA HERE]

THIS FRAME — MID-ARC
Identical camera, background, and lighting to Frames 1 and 2. The
arms are now roughly two-thirds of the way through the motion.
Elbows held slightly forward of the shoulders (not flared out
sideways). Forearms angle upward and inward; hands are at upper-
chest / lower-chin height, palm-cups clearly turning toward the
muzzle. There is a sense of considered, almost reluctant motion.
The pin joint at the shoulder is visible; the wood grain runs along
the arm.

NARRATIVE BEAT
The hands are rising toward the mouth. Slow, deliberate, warm.

ASPECT
1:1
```

## Frame 4 — Peak: hands over the mouth (the money shot)

```
[PASTE MASTER DNA HERE]

THIS FRAME — PEAK ("SHHH")
Identical camera, background, and lighting to the previous frames.
The arms have reached their peak position. Both hands are cupped
gently over the walnut muzzle insert — covering the entire lower
half of the face from just below the eye-board down to the chin.
Palm-cups pressed softly against the face. Elbows held slightly
forward of the shoulders, never flared outward.

CRUCIAL: the walnut eye-board and the two black bead eyes remain
fully visible ABOVE the cupped hands. The eyes look directly at
the viewer — attentive, gently insistent. This is the Iwazaru
"speak no evil" pose adapted for the office: the monkey is
silently telling YOU to quiet down. The eye-contact while the
mouth is covered is what makes the gesture land.

The pose reads with calm dignity, never cartoonish, never
exaggerated. The wood-grain on the arms catches the light.

NARRATIVE BEAT
The hero moment. The monkey has covered its mouth and is looking
right at you. The room receives the message.

ASPECT
1:1
```

## Frame 5 — Return (the gesture releases)

```
[PASTE MASTER DNA HERE]

THIS FRAME — RETURN
Identical camera, background, and lighting to the previous frames.
The arms have lowered back down to roughly the position of Frame 2 —
hands at mid-chest height, palms still angled inward, elbows just
beginning to straighten. The motion reads as reluctant release,
slower than the rise. Eyes still forward, attentive — they were
visible throughout. The figure is on its way back to the patient
resting pose.

NARRATIVE BEAT
The message has been delivered. The monkey returns to rest.

ASPECT
1:1
```

---

# SECTION B — CAD reference views (til 3D-model)

> Fem strict orthographic views. Til sculptor / CAD-arbejde efter pitchen. **Skal være helt rene** — ingen perspektiv, ingen baggrundselementer der konkurrerer med silhuetten.

## B1 — Front orthographic

```
[PASTE MASTER DNA HERE]

THIS VIEW — FRONT ORTHOGRAPHIC
Strict front orthographic projection. Camera dead-on at the monkey's
chest height, perfectly centered. Zero perspective distortion, zero
lens compression. The monkey stands at the resting pose (arms along
sides, ~5° forward of hips). The base disc is visible as a perfect
ellipse beneath the feet. Even, shadowless top light. Neutral warm-
white seamless backdrop. This is a measurement reference — every
proportion must be readable.

ASPECT
1:1
```

## B2 — Side profile (orthographic, camera-right)

```
[PASTE MASTER DNA HERE]

THIS VIEW — SIDE ORTHOGRAPHIC
Strict side orthographic projection from camera-right. Camera at
chest height, zero perspective. The monkey is in the resting pose.
The ~5° forward inclination of the arms should be clearly visible —
arms hang slightly in front of the hip line, not flush with the
body. The flowing shoulder-to-arm transition reads clearly in
profile, as does the toe-tip lift on the foot. Even shadowless
lighting. Neutral warm-white backdrop.

ASPECT
1:1
```

## B3 — Back orthographic

```
[PASTE MASTER DNA HERE]

THIS VIEW — BACK ORTHOGRAPHIC
Strict back orthographic projection. Camera dead-on behind the
monkey at chest height, perfectly centered. Zero perspective. The
back of the head, the spine-line seam of the torso (reading as a
body contour, not an assembly line), the back of the long arms and
legs, and the perfect ellipse of the base disc are all visible.
ABSOLUTELY NO visible access hatch, no USB cutout, no screws — the
back is a single sealed sculptural surface. Even shadowless
lighting. Neutral warm-white backdrop.

ASPECT
1:1
```

## B4 — Top-down orthographic

```
[PASTE MASTER DNA HERE]

THIS VIEW — TOP-DOWN ORTHOGRAPHIC
Strict bird's-eye orthographic projection straight down from above.
Camera centered over the head. Zero perspective. Visible from this
angle: the round top of the head, the egg-section of the torso, the
long arms hanging outside the torso line with their slight forward
inclination, the toed-out feet, and the round maple base disc
framing the whole composition. Even shadowless lighting. Neutral
warm-white backdrop.

ASPECT
1:1
```

## B5 — Three-quarter reference (perspective allowed)

```
[PASTE MASTER DNA HERE]

THIS VIEW — THREE-QUARTER REFERENCE
Three-quarter angle from front-left, camera at chest height. 50 mm
equivalent lens — gentle, faithful perspective, no wide-angle
distortion. The monkey is in the resting pose. Even, faintly directional
lighting from upper-left. Neutral warm-white seamless backdrop. The
goal is depth-reference: a sculptor should be able to use this
together with B1–B4 to rebuild the form in 3D.

ASPECT
1:1
```

---

# SECTION C — Detail shots

> Close-ups til både pitch og CAD-reference. Vis materialet, kvaliteten af kurverne, og at "the line smiles."

## C1 — Face close-up

```
[PASTE MASTER DNA HERE]

THIS SHOT — FACE MACRO
Macro shot of the face only, filling the frame. Three-quarter angle.
Show the depth of the ovoid recess on the front of the head, the
walnut eye-board sitting proud with its faint downward bow at
center, the two black glass bead eyes catching a single soft
highlight, and the small round walnut muzzle below. The subtle
brow ridge above the eye-board and the shallow cheek planes
flanking the muzzle should be readable in raking light. Skin-warm
tonal range. Very shallow depth of field.

ASPECT
1:1
```

## C2 — Hand close-up

```
[PASTE MASTER DNA HERE]

THIS SHOT — HAND MACRO
Macro shot of one hand and the lower forearm from a three-quarter
angle. Show the shallow inward palm-cup, the wrist tilt, the
cylindrical wrist-to-hand taper, the soft radius at every transition.
Birch grain visible along the length of the forearm. The hand
reads unmistakably as "designed to cup the face" — not as a sphere,
not as a club. Very shallow depth of field.

ASPECT
1:1
```

## C3 — Shoulder flow close-up

```
[PASTE MASTER DNA HERE]

THIS SHOT — SHOULDER FLOW MACRO
Macro shot of the shoulder transition from torso to arm, three-
quarter angle. Show how the torso swells outward and the arm grows
from it as one continuous flowing form — no visible joint line, no
clip-on look. The sculptural pin joint at the shoulder is purely
visual character, not mechanical. Grain runs along the arm.

ASPECT
1:1
```

## C4 — Base / material transition close-up

```
[PASTE MASTER DNA HERE]

THIS SHOT — BASE MATERIAL MACRO
Low-angle close-up of where the feet meet the base disc. Show the
slightly toed-out feet (~10°), the soft chamfered edge of the
maple disc, the tonal shift between the light birch body and the
medium-tone maple base. ABSOLUTELY NO visible USB notch, no port,
no hardware — the base reads as pure sculpture from this angle.
Single soft shadow under the disc.

ASPECT
1:1
```

---

# SECTION D — Validering

## D1 — Black silhouette iconicity test

```
[PASTE MASTER DNA HERE]

THIS SHOT — SILHOUETTE TEST
Pure black silhouette of the object against pure white background.
No texture, no shading, no inserts, no grain — just shape. The
monkey is in the resting pose. This is the iconicity test: at
thumbnail size the silhouette must read unmistakably as a Bojesen-
tribute monkey: spherical head, egg-torso, very long arms hanging
slightly forward, toed-out feet, round base disc.

ASPECT
1:1
```

---

## Låste valg 🔒

Disse er nu låst på tværs af alle 16 prompter. Skift kun ved bevidst beslutning, og opdater Master DNA hvis du gør.

- **Højde:** 220 mm
- **Pose:** stående, ikke siddende
- **Arme:** 135 mm (60% af højden), Bojesen-signaturlange
- **Arm-hvilevinkel:** ~5° foran hofteline (alert, ikke akavet)
- **Hænder:** shallow palm-cup med inward wrist tilt
- **Cover-position:** hænder kuppet over muzzle / nedre halvdel af ansigtet, palmer presset blødt mod den, albuer let frem. Eye-board og øjne forbliver synlige OVER hænderne — øjenkontakt bevares (Iwazaru "shh"-gestus, ikke see-no-evil)
- **Eye-board:** vandret lozenge ~32×12 mm med faint downward bow (smile-line)
- **Muzzle:** lille rund valnød-indsats, ~10 mm
- **Øjne:** 6 mm sorte glasperler i eye-board
- **Hage:** blødt afrundet plane (ikke fladt skåret)
- **Ear-discs:** flush, knapt synlige
- **Træ-toner:** lys birk krop, valnød eye-board + muzzle, medium ahorn base disc
- **Base disc:** 120 mm diameter, 10 mm tyk, blød chamfer
- **Skuldre:** flydende ind i torso (hull-style), ingen clip-on look
- **Fødder:** toed-out ~10°, tå-tip løfter forward-and-up
- **Seam:** følger spine-belly midline, læses som krops-kontur ikke samlingslinje
- **Brow + cheek planes:** subtile, til at give ansigt struktur uden inserts
- **Lys:** blødt nordligt dagslys fra øvre venstre
- **Baggrund:** neutral warm-white seamless
- **Skygge:** én blød samlet under base disc
- **Synlig teknologi:** ingen, ingen steder, i intet view

---

## Stadig åbne valg ❓

Disse vil image gen besvare for os — variér første gang vi genererer Hero, og lås det vinder.

- **Hand-cover-spread ved mund:** hænderne mødes tæt over muzzle (én sammenhængende cup) vs. let separerede (to tydelige cups der lige rører hinanden ved midten). Sandsynlig vinder: tæt sammen — den læser som "shh" på lang afstand.
- **Forearm-vinkel ved peak:** parallelle (begge underarme symmetriske, lige op) vs. let krydsede (højre underarm krydser foran venstre eller omvendt). Sandsynlig vinder: parallelle — symmetri understøtter den rolige Bojesen-dignitet.
- **Underansigts-dækning:** hænderne dækker præcis muzzle vs. dækker hele området fra under eye-board til hage. Sandsynlig vinder: dækker området fra under eye-board til hage — mere dækning, klarere gestus, men eye-board forbliver fuldt synligt.
- **Bokeh-baggrund i story arc:** kontor-bokeh vs. helt ren backdrop. Sandsynlig vinder: meget subtil kontor-bokeh — fortæller historien uden at distrahere.

---

## Negative prompt (paste til slut hvis modellen tager negative prompts)

```
no plastic, no shiny surface, no 3D print layer lines, no screws,
no visible electronics, no USB port, no cables, no LEDs, no servo
motor, no painted features, no cartoon eyes, no mouth, no
nostrils, no tail, no separated fingers, no toy aesthetic, no
Halloween animatronic look, no robot, no metal fittings, no
glossy lacquer, no logo, no text, no human figures in background,
no perspective distortion in orthographic views, no fish-eye lens.
```

---

## Iterations-log

> Skriv her hvad vi prøver i hver runde, og hvad vi beslutter.

| Runde | Prompt | Resultat | Beslutning |
|---|---|---|---|
| — | — | — | — |
