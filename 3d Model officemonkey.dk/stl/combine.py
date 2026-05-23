#!/usr/bin/env python3
"""
Combine all Tys-aben V1.1 wall variant + hub STLs into a single
print-ready file laid out on a Bambu Lab P1S / X1C build plate
(256 × 256 mm).

All parts are translated so their bottoms touch the bed (z=0) and
positioned with ≥6 mm spacing for safe brim/skirt clearance.

Output: tys-aben-all-parts.stl (single file containing all 17 parts
as separate watertight bodies — slicer treats them as distinct
objects on the plate).

Usage:
    /tmp/mesh-venv/bin/python combine.py
"""

import os
import sys
from pathlib import Path

try:
    import trimesh
    import numpy as np
except ImportError:
    print("ERROR: trimesh required. Use /tmp/mesh-venv/bin/python combine.py")
    sys.exit(1)

REPO = Path(__file__).parent.parent  # /Users/gl/office-monkey-hackaton
# V1.1 STLs live in the "3d Model officemonkey.dk/" subfolder on main branch
ROOT = REPO / "3d Model officemonkey.dk"
WALL = ROOT / "stl" / "wall"
HUB = ROOT / "stl" / "hub"

# Layout: (filename, x_center_mm, y_center_mm, z_rotation_deg)
# Bambu P1S build plate is 256×256 mm, origin centered at (0,0).
# Safe area: (-123, -123) to (123, 123) with 5 mm margin.
#
# Strategy:
#   - Hub box + lid: large parts (75×150 mm) → top of plate
#   - Monkey body parts: middle of plate
#   - Arms + legs (long, cylindrical) → printed STANDING UP so layer
#     lines run along the limb (Bojesen wood-grain effect after oil).
#     Their bounding-box footprint when standing is small (~15×15).
#   - Small parts (eye_board, muzzle, yoke, servo_bracket, mic_bracket,
#     bottom_plate) → bottom row, packed tight.

LAYOUT = [
    # Large parts — top half (y > 0)
    (HUB / "hub_box.stl",      -50,   45, 0),
    (HUB / "hub_lid.stl",       50,   45, 0),

    # Body — middle row (y ≈ -30)
    (WALL / "head.stl",         -90,  -35, 0),
    (WALL / "torso_front.stl",  -25,  -35, 0),
    (WALL / "torso_back.stl",    35,  -35, 0),

    # Limbs — bottom row, printed standing (small footprint)
    (WALL / "upper_arm_left.stl",   85,  -50, 0),
    (WALL / "upper_arm_right.stl", 105,  -50, 0),
    (WALL / "forearm_left.stl",    -110, -80, 0),
    (WALL / "forearm_right.stl",   -90,  -80, 0),
    (WALL / "leg_left.stl",        -70,  -80, 0),
    (WALL / "leg_right.stl",       -50,  -80, 0),

    # Small parts — bottom edge
    (WALL / "eye_board.stl",       -25, -95, 0),
    (WALL / "muzzle.stl",            5, -95, 0),
    (WALL / "bottom_plate.stl",     25, -85, 0),
    (WALL / "yoke.stl",             55, -95, 0),
    (WALL / "servo_bracket.stl",    75, -85, 0),
    (WALL / "mic_bracket.stl",     105, -85, 0),
]

PLATE_HALF = 128.0   # 256/2
MARGIN = 5.0

def position_part(mesh, x, y, rot_deg):
    """Translate mesh so z_min=0, center XY at (x, y), then apply Z rotation."""
    if rot_deg != 0:
        rot = trimesh.transformations.rotation_matrix(
            np.deg2rad(rot_deg), [0, 0, 1])
        mesh.apply_transform(rot)
    bounds = mesh.bounds  # [[min_x, min_y, min_z], [max_x, max_y, max_z]]
    cx = (bounds[0][0] + bounds[1][0]) / 2
    cy = (bounds[0][1] + bounds[1][1]) / 2
    cz = bounds[0][2]
    mesh.apply_translation([x - cx, y - cy, -cz])
    return mesh

def main():
    out_path = ROOT / "stl" / "tys-aben-all-parts.stl"
    print(f"Combining {len(LAYOUT)} parts onto a 256 × 256 mm plate…")

    meshes = []
    for stl_path, x, y, rot in LAYOUT:
        if not stl_path.exists():
            print(f"  ✗ MISSING: {stl_path}")
            continue
        m = trimesh.load(str(stl_path))
        position_part(m, x, y, rot)
        ext = m.extents
        bounds = m.bounds
        # Plate-bounds check
        ok_x = abs(bounds[0][0]) <= PLATE_HALF - MARGIN and abs(bounds[1][0]) <= PLATE_HALF - MARGIN
        ok_y = abs(bounds[0][1]) <= PLATE_HALF - MARGIN and abs(bounds[1][1]) <= PLATE_HALF - MARGIN
        flag = "✓" if (ok_x and ok_y) else "⚠ OFF PLATE"
        print(f"  {stl_path.name:<22} @ ({x:+4d}, {y:+4d})  {ext[0]:5.1f} × {ext[1]:5.1f} × {ext[2]:5.1f}  {flag}")
        meshes.append(m)

    combined = trimesh.util.concatenate(meshes)
    combined.export(str(out_path))
    size_mb = out_path.stat().st_size / (1024 * 1024)
    total_vol = sum(m.volume for m in meshes) / 1000  # cm³
    print(f"\n✓ Saved {out_path}")
    print(f"  Parts: {len(meshes)}  ·  File size: {size_mb:.1f} MB")
    print(f"  Total mesh volume: {total_vol:.1f} cm³")
    print(f"  Est. filament @ 25% effective density: {total_vol * 0.25 * 1.24:.0f} g")

if __name__ == "__main__":
    main()
