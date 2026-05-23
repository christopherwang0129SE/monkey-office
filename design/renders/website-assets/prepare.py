#!/usr/bin/env python3
"""Prepare officemonkey.dk site assets from the existing Tys-aben renders.

Outputs (next to this file):
  monkey-hero.png   — 3:4 portrait, the Iwazaru "shh" pitch image (Plate I).
  monkey-chat.png   — 512x512 square, tight head/shoulders for the "Spørg Mo" avatar.
  birdie-logo.png   — 1024x1024 square, full figure for header/footer logo.
"""

from pathlib import Path
from PIL import Image

HERE = Path(__file__).parent
SRC = HERE.parent
PEAK = SRC / "frame-4-peak-20260523-144536.png"
IDLE = SRC / "hero-20260523-143831.png"


def crop_portrait_3x4(im: Image.Image) -> Image.Image:
    w, h = im.size
    target_w = int(h * 3 / 4)
    if target_w <= w:
        left = (w - target_w) // 2
        return im.crop((left, 0, left + target_w, h))
    target_h = int(w * 4 / 3)
    top = (h - target_h) // 2
    return im.crop((0, top, w, top + target_h))


def crop_square(im: Image.Image, top: float, height: float) -> Image.Image:
    """Crop a square region. top/height are fractions of image height; centered horizontally."""
    w, h = im.size
    side = int(h * height)
    y0 = int(h * top)
    x0 = (w - side) // 2
    return im.crop((x0, y0, x0 + side, y0 + side))


def main() -> None:
    peak = Image.open(PEAK).convert("RGB")
    idle = Image.open(IDLE).convert("RGB")

    # 1. Hero — the "shh" pitch image, 3:4 portrait, ~768x1024.
    hero = crop_portrait_3x4(peak)
    hero.save(HERE / "monkey-hero.png", optimize=True)
    print(f"hero  {hero.size}  →  monkey-hero.png")

    # 2. Chat avatar — tight head + shoulders, 512x512.
    #    Head sits roughly in the upper third of the figure (y 8% – 38%).
    chat = crop_square(idle, top=0.08, height=0.32).resize((512, 512), Image.LANCZOS)
    chat.save(HERE / "monkey-chat.png", optimize=True)
    print(f"chat  {chat.size}  →  monkey-chat.png")

    # 3. Logo — full figure on its base, square, 1024x1024.
    logo = crop_square(idle, top=0.0, height=1.0)
    logo.save(HERE / "birdie-logo.png", optimize=True)
    print(f"logo  {logo.size}  →  birdie-logo.png")


if __name__ == "__main__":
    main()
