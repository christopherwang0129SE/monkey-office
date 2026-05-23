// =====================================================================
//  Tys-aben — External Hardware Hub
//  ---------------------------------------------------------------------
//  A separate small wooden enclosure that holds the components that
//  cannot fit inside Aben herself:
//    * Motherboard (60 × 7 × 120 mm) — lies flat in the bottom
//    * DC motor (19.5 × 19.1 × 48.3 mm) — stands vertically next to board
//    * USB-C breakout (19.5 × 10.2 × 19.8 mm) — wall-side port
//    * Spare room for wiring + tendon-pulley if motor drives tendons
//      remotely
//
//  Designed to sit on the desk behind the monkey or mount on the wall
//  immediately below it. Same wood-fill PLA + linseed-oil finish as the
//  monkey itself — reads as a deliberate matching object, not a brick.
//
//  Coordinate system: Z up, +Y forward (out from wall / facing monkey).
//  Units: millimetres.
// =====================================================================

part = "preview";   // "preview" | "hub_box" | "hub_lid"

// ---------- OUTER ENVELOPE ----------
hub_w              = 70;       // X — width (matches motherboard width + walls + margin)
hub_l              = 145;      // Y — length (motherboard 120 mm + margin)
hub_h              = 24;       // Z — height (motherboard 7 mm thick + DC motor laid flat 19 mm + margin)
wall_t             = 2.5;
corner_r           = 6;
fit_loose          = 0.4;

// ---------- COMPONENT DIMENSIONS (matches hardware/components/ STLs) ----------
mb_w               = 60;
mb_l               = 120;
mb_h               = 7;
motor_w            = 19.5;
motor_l            = 19.1;
motor_h            = 48.3;
usbc_w             = 19.5;
usbc_d             = 10.2;
usbc_h             = 19.8;

// ---------- CABLE INLET (top — wires up to the monkey) ----------
inlet_w            = 14;
inlet_h            = 8;

// ---------- RESOLUTION ----------
$fa = 2;
$fs = 0.5;
$fn_smooth         = 80;

// =====================================================================
//  HELPERS
// =====================================================================

module rounded_box(w, d, h, r=2) {
    hull() {
        for (x=[-1,1], y=[-1,1], z=[-1,1])
            translate([x*(w/2-r), y*(d/2-r), z*(h/2-r)]) sphere(r);
    }
}

module rounded_plate(w, d, h, r) {
    linear_extrude(height=h)
        offset(r=r) offset(r=-r)
            square([w, d], center=true);
}

// =====================================================================
//  HUB BOX  (the lower shell — motherboard + motor live here)
// =====================================================================

module hub_box() {
    difference() {
        // Outer shell
        rounded_plate(hub_w, hub_l, hub_h, corner_r);
        // Internal cavity — open top, closed bottom (lid closes the top)
        translate([0, 0, wall_t])
            rounded_plate(hub_w - 2*wall_t, hub_l - 2*wall_t, hub_h, corner_r - wall_t/2);
        // Cable inlet on the TOP rear edge — wires up to the monkey
        translate([0, hub_l/2 - 4, hub_h - inlet_h/2 - 0.5])
            rotate([0, 0, 0])
                rounded_box(inlet_w, 10, inlet_h, r=1.5);
        // USB-C breakout cutout on rear wall (for power input)
        translate([0, hub_l/2 + 0.1, 7])
            rotate([90, 0, 0])
                rounded_box(usbc_w + 1, usbc_d + 1, wall_t*2 + 1, r=1);
        // Lid magnet pockets — 4 corners on the top rim
        for (x=[-1,1], y=[-1,1])
            translate([x*(hub_w/2 - 6), y*(hub_l/2 - 6), hub_h - 2.4])
                cylinder(d=5.2, h=2.6);
        // Mounting screw holes on the back wall (for wall-mounting under monkey)
        for (s=[-1,1])
            translate([s*(hub_w/2 - 12), hub_l/2 + 0.1, hub_h/2])
                rotate([90, 0, 0])
                    cylinder(d=4.5, h=wall_t*2 + 1);
    }

    // Motherboard rails — board lies flat against the bottom, held by 4 raised pegs
    mb_z = wall_t;
    for (x=[-1,1], y=[-1,1])
        translate([x*(mb_w/2 + 1), y*(mb_l/2 + 1), mb_z])
            cylinder(d=4, h=4);

    // (DC motor cradle removed — V1 uses SG90 servo inside the monkey's
    // torso, not a DC motor in the hub. DC motor is parked as a V2 spare.)
}

// =====================================================================
//  HUB LID  (snaps onto the top of the box via 4 magnets)
// =====================================================================

module hub_lid() {
    lid_t = 3;
    inset = wall_t + 0.2;
    difference() {
        union() {
            // Top plate
            rounded_plate(hub_w, hub_l, lid_t, corner_r);
            // Lower inset that drops into the box cavity
            translate([0, 0, -wall_t + 0.4])
                rounded_plate(hub_w - 2*inset, hub_l - 2*inset, wall_t - 0.4, corner_r - inset/2);
        }
        // Magnet pockets to mate with the box's magnets
        for (x=[-1,1], y=[-1,1])
            translate([x*(hub_w/2 - 6), y*(hub_l/2 - 6), lid_t/2 - 1.4])
                cylinder(d=5.2, h=2.6);
    }
}

// =====================================================================
//  RENDER
// =====================================================================

module preview() {
    color("burlywood") hub_box();
    translate([0, 0, hub_h + 6])
        color("peru") hub_lid();
}

if      (part == "preview") preview();
else if (part == "hub_box") hub_box();
else if (part == "hub_lid") hub_lid();
