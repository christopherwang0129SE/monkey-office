#!/usr/bin/env python3
"""
Combine Tys-aben STLs into single print-ready files.

Outputs:
  - tys-aben-wall-complete.stl    — wall variant V1.1 (17 parts on plate)
  - tys-aben-desktop-complete.stl — desktop variant V0.3 (13 parts on plate)

Both files sized for Bambu Lab P1S / X1C build plate (256 × 256 mm).
All parts touch the bed (z=0) with ≥6 mm spacing.

Usage:
    /tmp/mesh-venv/bin/python combine.py
"""

import sys
from pathlib import Path

try:
    import trimesh
    import numpy as np
except ImportError:
    print("ERROR: trimesh required. Use /tmp/mesh-venv/bin/python combine.py")
    sys.exit(1)

ROOT = Path(__file__).parent.parent  # 3d Model officemonkey.dk/
WALL = ROOT / "stl" / "wall"
HUB = ROOT / "stl" / "hub"
DESKTOP = ROOT / "stl"

PLATE_HALF = 128.0
MARGIN = 5.0

# Wall + hub layout (V1.1, 17 parts)
WALL_LAYOUT = [
    (HUB / "hub_box.stl",      -50,   45, 0),
    (HUB / "hub_lid.stl",       50,   45, 0),
    (WALL / "head.stl",         -90,  -35, 0),
    (WALL / "torso_front.stl",  -25,  -35, 0),
    (WALL / "torso_back.stl",    35,  -35, 0),
    (WALL / "upper_arm_left.stl",   85,  -50, 0),
    (WALL / "upper_arm_right.stl", 105,  -50, 0),
    (WALL / "forearm_left.stl",    -110, -80, 0),
    (WALL / "forearm_right.stl",   -90,  -80, 0),
    (WALL / "leg_left.stl",        -70,  -80, 0),
    (WALL / "leg_right.stl",       -50,  -80, 0),
    (WALL / "eye_board.stl",       -25, -95, 0),
    (WALL / "muzzle.stl",            5, -95, 0),
    (WALL / "bottom_plate.stl",     25, -85, 0),
    (WALL / "yoke.stl",             55, -95, 0),
    (WALL / "servo_bracket.stl",    75, -85, 0),
    (WALL / "mic_bracket.stl",     105, -85, 0),
]

# Desktop V0.3 layout (13 parts, 220 mm tall monkey)
DESKTOP_LAYOUT = [
    (DESKTOP / "base_disc.stl",      0,   80, 0),
    (DESKTOP / "head.stl",         -65, -15, 0),
    (DESKTOP / "torso_front.stl",   20,   5, 0),
    (DESKTOP / "torso_back.stl",    20, -35, 0),
    (DESKTOP / "arm_left.stl",      85,   30, 0),
    (DESKTOP / "arm_right.stl",    110,   30, 0),
    (DESKTOP / "leg_left.stl",      85,  -65, 0),
    (DESKTOP / "leg_right.stl",    110,  -65, 0),
    (DESKTOP / "eye_board.stl",    -60, -85, 0),
    (DESKTOP / "muzzle.stl",       -30, -90, 0),
    (DESKTOP / "bottom_plate.stl", -10, -75, 0),
    (DESKTOP / "yoke.stl",          25, -95, 0),
    (DESKTOP / "servo_bracket.stl", 55, -85, 0),
]


def position_part(mesh, x, y, rot_deg):
    if rot_deg != 0:
        rot = trimesh.transformations.rotation_matrix(
            np.deg2rad(rot_deg), [0, 0, 1])
        mesh.apply_transform(rot)
    bounds = mesh.bounds
    cx = (bounds[0][0] + bounds[1][0]) / 2
    cy = (bounds[0][1] + bounds[1][1]) / 2
    cz = bounds[0][2]
    mesh.apply_translation([x - cx, y - cy, -cz])
    return mesh


def combine(layout, label, out_filename):
    out_path = ROOT / "stl" / out_filename
    print(f"\n=== {label} ===")
    print(f"Combining {len(layout)} parts onto a 256 × 256 mm plate…")

    meshes = []
    for stl_path, x, y, rot in layout:
        if not stl_path.exists():
            print(f"  ✗ MISSING: {stl_path}")
            continue
        m = trimesh.load(str(stl_path))
        position_part(m, x, y, rot)
        ext = m.extents
        bounds = m.bounds
        ok_x = abs(bounds[0][0]) <= PLATE_HALF - MARGIN and abs(bounds[1][0]) <= PLATE_HALF - MARGIN
        ok_y = abs(bounds[0][1]) <= PLATE_HALF - MARGIN and abs(bounds[1][1]) <= PLATE_HALF - MARGIN
        flag = "✓" if (ok_x and ok_y) else "⚠ OFF PLATE"
        print(f"  {stl_path.name:<22} @ ({x:+4d}, {y:+4d})  {ext[0]:5.1f} × {ext[1]:5.1f} × {ext[2]:5.1f}  {flag}")
        meshes.append(m)

    if not meshes:
        print(f"  ⚠ No parts found — skipping {label}")
        return

    combined = trimesh.util.concatenate(meshes)
    combined.export(str(out_path))
    size_mb = out_path.stat().st_size / (1024 * 1024)
    total_vol = sum(m.volume for m in meshes) / 1000
    print(f"\n  ✓ Saved {out_path.name}")
    print(f"  Parts: {len(meshes)}  ·  File size: {size_mb:.1f} MB")
    print(f"  Combined extent: {combined.extents[0]:.1f} × {combined.extents[1]:.1f} × {combined.extents[2]:.1f} mm")
    print(f"  Est. filament @ 25% effective density: {total_vol * 0.25 * 1.24:.0f} g")


def main():
    combine(WALL_LAYOUT, "WALL V1.1 (124 mm hanging monkey + external hub)",
            "tys-aben-wall-complete.stl")
    combine(DESKTOP_LAYOUT, "DESKTOP V0.3 (220 mm standing monkey)",
            "tys-aben-desktop-complete.stl")
    print("\n" + "=" * 60)
    print("Both variants ready. Choose one:")
    print("  • tys-aben-wall-complete.stl    → 17 parts, ~64g, ~6h print")
    print("  • tys-aben-desktop-complete.stl → 13 parts, ~167g, ~21h print")
    print("=" * 60)


if __name__ == "__main__":
    main()
