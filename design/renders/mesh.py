#!/usr/bin/env python3
"""
Generate a 3D mesh from a generated render using fal.ai.

Default model: Trellis (Microsoft) — top quality for static objects.
Alternative: fal-ai/tripo (Tripo3D) or fal-ai/hunyuan3d-v2.

Usage:
    python3 mesh.py <image-name.png>
    python3 mesh.py frame-4-peak-20260523-144536.png
    python3 mesh.py frame-4-peak-20260523-144536.png tripo
"""

import base64
import json
import sys
import time
import urllib.request
import urllib.error
from pathlib import Path

MODELS = {
    "trellis": "fal-ai/trellis",
    "tripo": "fal-ai/tripo",
    "hunyuan": "fal-ai/hunyuan3d-v2",
    "triposr": "fal-ai/triposr",
}


def load_fal_key() -> str:
    env_file = Path("/Users/gl/forbrugeragent/backend/.env")
    for line in env_file.read_text().splitlines():
        if line.startswith("FAL_KEY="):
            return line.split("=", 1)[1].strip().strip('"').strip("'")
    raise SystemExit("FAL_KEY not found in .env")


def call(url: str, key: str, method="GET", payload=None):
    headers = {"Authorization": f"Key {key}"}
    if payload is not None:
        headers["Content-Type"] = "application/json"
        data = json.dumps(payload).encode()
    else:
        data = None
    req = urllib.request.Request(url, method=method, headers=headers, data=data)
    try:
        with urllib.request.urlopen(req, timeout=120) as resp:
            return json.loads(resp.read())
    except urllib.error.HTTPError as e:
        body = e.read().decode("utf-8", errors="replace")
        raise SystemExit(f"{method} {url} → {e.code}: {body}")


def main():
    if len(sys.argv) < 2:
        raise SystemExit("Usage: mesh.py <image.png> [trellis|tripo|hunyuan|triposr]")

    img_name = sys.argv[1]
    model_key = sys.argv[2] if len(sys.argv) > 2 else "trellis"
    model_path = MODELS.get(model_key, model_key)

    img_path = Path(__file__).parent / img_name
    if not img_path.exists():
        raise SystemExit(f"Not found: {img_path}")

    fal_key = load_fal_key()

    # Base64 inline (avoid separate upload roundtrip)
    img_b64 = base64.b64encode(img_path.read_bytes()).decode()
    img_url = f"data:image/png;base64,{img_b64}"

    print(f"→ {model_path}: submitting {img_name} ({len(img_b64)//1024} KB b64)…")
    submit = call(
        f"https://queue.fal.run/{model_path}",
        fal_key,
        method="POST",
        payload={"image_url": img_url},
    )
    print(f"  request_id: {submit.get('request_id')}")

    status_url = submit["status_url"]
    response_url = submit["response_url"]

    print("→ Polling status…")
    t0 = time.time()
    while True:
        st = call(status_url, fal_key)
        elapsed = time.time() - t0
        print(f"  [{elapsed:5.1f}s] {st['status']}")
        if st["status"] == "COMPLETED":
            break
        if st["status"] in ("FAILED", "ERROR"):
            raise SystemExit(f"Generation failed: {st}")
        time.sleep(3)

    result = call(response_url, fal_key)
    print(f"→ Result keys: {list(result.keys())}")

    # Trellis returns: {"model_mesh": {"url": ...}, ...}
    # Tripo returns:   {"model_mesh": {"url": ...}, ...}
    # Hunyuan returns: {"model_mesh": {"url": ...}, ...}
    mesh_obj = result.get("model_mesh") or result.get("mesh") or result.get("output")
    if isinstance(mesh_obj, dict):
        mesh_url = mesh_obj.get("url")
    elif isinstance(mesh_obj, str):
        mesh_url = mesh_obj
    else:
        raise SystemExit(f"Cannot find mesh URL in result: {result}")

    ts = time.strftime("%Y%m%d-%H%M%S")
    stem = Path(img_name).stem
    out = Path(__file__).parent / f"mesh-{stem}-{model_key}-{ts}.glb"
    urllib.request.urlretrieve(mesh_url, out)
    size_mb = out.stat().st_size / (1024 * 1024)
    print(f"✓ Saved {out} ({size_mb:.1f} MB)")

    # Also save the full result for debugging
    debug_out = out.with_suffix(".json")
    debug_out.write_text(json.dumps(result, indent=2))
    print(f"  + debug: {debug_out}")


if __name__ == "__main__":
    main()
