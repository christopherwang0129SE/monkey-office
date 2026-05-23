#!/usr/bin/env python3
"""
Generate Tys-aben renders via OpenAI gpt-image-1.

Usage:
    python3 generate.py hero
    python3 generate.py frame-1
    python3 generate.py b1-front
    ...

Loads OPENAI_API_KEY from /Users/gl/forbrugeragent/backend/.env.
Writes PNG to ./<name>-<timestamp>.png next to this script.
"""

import base64
import json
import sys
import time
import urllib.request
import urllib.error
from pathlib import Path

# ────────────────────────────────────────────────────────────────────
# Master DNA — gentages i hver prompt. Holdes 1:1 med image-spec.md.
# ────────────────────────────────────────────────────────────────────

MASTER_DNA = """\
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
"""

# ────────────────────────────────────────────────────────────────────
# Prompts — varianter, hver tilføjes til Master DNA.
# ────────────────────────────────────────────────────────────────────

PROMPTS = {
    "hero": """\
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
""",
    "frame-1": """\
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
""",
    "frame-4-peak": """\
THIS FRAME — PEAK "SHHH" (THE PRODUCT'S ONE PITCH IMAGE)

This is the single image that pitches the product. The monkey is
caught in the middle of its one signature gesture: BOTH HANDS
CUPPED OVER ITS OWN MOUTH, silently telling the room to be quiet.

POSE
- Both arms raised and bent symmetrically, forearms angling
  upward and inward toward the lower face.
- The hands meet in front of the LOWER half of the face, palms
  pressed gently against the walnut muzzle insert. The cupped
  hands cover the area from just below the eye-board down to the
  chin — the entire "mouth zone".
- Elbows held slightly forward of the shoulders, NOT flared out
  sideways like wings.

CRITICAL — THE EYE CONTACT
The walnut eye-board and the two black bead eyes are FULLY VISIBLE
ABOVE the cupped hands. The eyes look DIRECTLY AT THE CAMERA —
attentive, gently insistent. The monkey is silently telling YOU
to quiet down, while looking straight at you. This eye contact
is what makes the gesture land.

ARM LENGTH — CRUCIAL, DO NOT SHORTEN
The arms are DRAMATICALLY LONG, like Kay Bojesen's iconic monkey.
Fully extended along the body they would reach nearly to the
knees. The forearms are clearly long, not stubby. Even folded up
to the face, the long arm length must be readable — long forearms
crossing in front of the chest, long upper arms swinging from
flowing shoulders. This is the single most important visual
signature.

HANDS
The hands are smooth, rounded WOODEN MITTENS — soft cupped forms
like polished river stones or oversized wooden thimbles, with a
subtle concave dip on the palm-facing side. ABSOLUTELY NOT claws,
NOT pointed, NOT clawed crab-like shapes, NOT articulated robotic
grippers. Imagine simple wooden teacups pressed against the face.

SHOULDERS
The arm flows out of the torso as ONE CONTINUOUS FORM. The torso
swells outward at the shoulder and the arm grows from it like a
branch from a tree trunk — no visible joint line, no "bolted-on"
look, no abrupt right angle. The shoulder is a fluid hull-style
transition.

EARS
The ears are FLUSH WITH THE HEAD — small, vestigial, barely
perceptible. Not protruding. The silhouette is monkey-shaped
through proportions, not through cartoon ears.

CAMERA & STYLE
Three-quarter front view, slight rotation to camera-left so we
see depth on the right shoulder and forearm. Camera at the
monkey's chest height. 85 mm equivalent lens, shallow depth of
field with the face and hands in critical focus. The figure
fills the frame with comfortable headroom. Empty warm-white
seamless backdrop. Soft northern daylight from upper-left. Single
soft shadow under the base disc.

The pose reads with calm dignity, never cartoonish, never
exaggerated. The wood grain catches the light along the long
forearms.

NARRATIVE
The hero shot. The monkey has covered its own mouth and is
looking directly at the viewer. This is the silent "shh." This
is the product, captured in one frame.
""",
    "b1-front": """\
THIS VIEW — FRONT ORTHOGRAPHIC
Strict front orthographic projection. Camera dead-on at the monkey's
chest height, perfectly centered. Zero perspective distortion, zero
lens compression. The monkey stands at the resting pose (arms along
sides, ~5° forward of hips). The base disc is visible as a perfect
ellipse beneath the feet. Even, shadowless top light. Neutral warm-
white seamless backdrop. This is a measurement reference — every
proportion must be readable.
""",
    "b2-side": """\
THIS VIEW — SIDE ORTHOGRAPHIC
Strict side orthographic projection from camera-right. Camera at
chest height, zero perspective. The monkey is in the resting pose.
The ~5° forward inclination of the arms should be clearly visible —
arms hang slightly in front of the hip line, not flush with the
body. The flowing shoulder-to-arm transition reads clearly in
profile, as does the toe-tip lift on the foot. Even shadowless
lighting. Neutral warm-white backdrop.
""",
    "d1-silhouette": """\
THIS SHOT — SILHOUETTE TEST
Pure black silhouette of the object against pure white background.
No texture, no shading, no inserts, no grain — just shape. The
monkey is in the resting pose. This is the iconicity test: at
thumbnail size the silhouette must read unmistakably as a Bojesen-
tribute monkey: spherical head, egg-torso, very long arms hanging
slightly forward, toed-out feet, round base disc.
""",
}


def load_api_key() -> str:
    env_file = Path("/Users/gl/forbrugeragent/backend/.env")
    for line in env_file.read_text().splitlines():
        if line.startswith("OPENAI_API_KEY="):
            return line.split("=", 1)[1].strip().strip('"').strip("'")
    raise RuntimeError("OPENAI_API_KEY not found in .env")


def generate(name: str, size: str = "1024x1024", quality: str = "high") -> Path:
    if name not in PROMPTS:
        raise SystemExit(f"Unknown prompt '{name}'. Available: {sorted(PROMPTS)}")

    api_key = load_api_key()
    prompt = MASTER_DNA + "\n" + PROMPTS[name]

    payload = json.dumps({
        "model": "gpt-image-2",
        "prompt": prompt,
        "size": size,
        "quality": quality,
        "n": 1,
    }).encode()

    req = urllib.request.Request(
        "https://api.openai.com/v1/images/generations",
        method="POST",
        headers={
            "Authorization": f"Bearer {api_key}",
            "Content-Type": "application/json",
        },
        data=payload,
    )

    print(f"→ Sending {len(prompt)} chars to gpt-image-2 ({quality}, {size})…")
    t0 = time.time()
    try:
        with urllib.request.urlopen(req, timeout=300) as resp:
            data = json.loads(resp.read())
    except urllib.error.HTTPError as e:
        body = e.read().decode("utf-8", errors="replace")
        raise SystemExit(f"OpenAI HTTPError {e.code}: {body}")

    elapsed = time.time() - t0
    image_b64 = data["data"][0]["b64_json"]
    img_bytes = base64.b64decode(image_b64)

    ts = time.strftime("%Y%m%d-%H%M%S")
    out = Path(__file__).parent / f"{name}-{ts}.png"
    out.write_bytes(img_bytes)
    print(f"✓ Saved {out} ({len(img_bytes)/1024:.0f} KB, {elapsed:.1f}s)")
    return out


if __name__ == "__main__":
    name = sys.argv[1] if len(sys.argv) > 1 else "hero"
    quality = sys.argv[2] if len(sys.argv) > 2 else "high"
    generate(name, quality=quality)
