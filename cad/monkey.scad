// =====================================================================
//  Aben — parametric Bojesen-tribute monkey, V0.3
//  ---------------------------------------------------------------------
//  V0.3 moves (from design-critique.md):
//    1. Standing pose — straight legs, feet on ground (was seated)
//    2. Long arms — 130 mm, 59% of total height (Bojesen signature)
//    3. Flowing shoulder — torso swells outward at shoulder via hull(),
//       arm root matches the curve; no clip-on look
//    4. Wooden base disc — separate part, hides USB-C and houses
//       servicing access; back hatch removed entirely
//    5. Bottom hatch on torso (invisible when standing on base)
//    6. Alert rest posture — arms hang slightly forward
//
//  Coordinate system: Z=0 at ground (bottom of base disc),
//                     +Z up, +Y forward (toward viewer), +X to the right.
//
//  Units: millimetres.
// =====================================================================

part = "preview";   // "preview" | "triggered" | "head" | "torso_front"
                    // | "torso_back" | "bottom_plate" | "arm_left"
                    // | "arm_right" | "leg_left" | "leg_right"
                    // | "eye_board" | "muzzle" | "base_disc"
                    // | "servo_bracket" | "yoke"

// ---------- BODY DIMENSIONS ----------
total_h            = 220;                      // monkey only (excludes base)
foot_h             = 18;                       // foot bulb height
leg_h              = 60;                       // hip to foot
torso_h            = 80;
head_h             = 72;
torso_w            = 70;
torso_d            = 55;
head_w             = 66;
head_d_front       = 70;
arm_total_l        = 130;                      // 59% of total_h — Bojesen-long
shoulder_z         = leg_h + foot_h + torso_h*0.85;  // ~177
torso_center_z     = leg_h + foot_h + torso_h/2;     // ~118
head_center_z      = leg_h + foot_h + torso_h + head_h/2 - 8; // overlap for neck

// ---------- BASE DISC ----------
base_d             = 95;                       // wider than monkey for stability
base_h             = 14;
base_foot_recess   = 4;
base_usb_notch_w   = 10;
base_usb_notch_h   = 5;

// ---------- FACE / DETAIL ----------
eyeboard_w         = 38;
eyeboard_h         = 14;
eye_d              = 6;
eye_spacing        = 19;
muzzle_d           = 15;
face_recess_depth  = 3.5;

// ---------- WALL & FIT ----------
wall               = 2.4;
fit_loose          = 0.4;
fit_tight          = 0.2;

// ---------- MECHANISM ----------
sg90_body_l        = 23.0;
sg90_body_w        = 12.2;
sg90_body_h        = 22.5;
esp_w              = 28;
esp_l              = 65;
shoulder_pin_d     = 3.2;
tendon_ch_d        = 2.4;

// ---------- RESOLUTION ----------
$fa = 3;
$fs = 0.8;
$fn_smooth         = 64;

// =====================================================================
//  HELPERS
// =====================================================================

module ovoid(w, d, h) {
    scale([w/2, d/2, h/2]) sphere(r=1, $fn=$fn_smooth);
}

module rounded_box(w, d, h, r=3) {
    hull() {
        for (x=[-1,1], y=[-1,1], z=[-1,1])
            translate([x*(w/2-r), y*(d/2-r), z*(h/2-r)]) sphere(r);
    }
}

module lozenge(w, h, t) {
    hull() {
        translate([-(w-h)/2, 0, 0]) cylinder(d=h, h=t);
        translate([ (w-h)/2, 0, 0]) cylinder(d=h, h=t);
    }
}

// Organic limb: hull of spheres at [z, diameter] control points
module tapered_limb(points) {
    hull() for (p = points)
        translate([0, 0, p[0]]) sphere(d=p[1], $fn=$fn_smooth);
}

// =====================================================================
//  HEAD
// =====================================================================

module head_solid() {
    union() {
        // Ovoid cranium
        ovoid(head_w, head_d_front, head_h);
        // Soft chin (no flat cut)
        translate([0, head_d_front*0.04, -head_h*0.40])
            scale([0.85, 0.85, 0.7]) sphere(d=head_w*0.65, $fn=$fn_smooth);
        // Subtle brow ridge
        translate([0, head_d_front*0.16, head_h*0.05])
            scale([1, 0.55, 0.35]) sphere(d=head_w*0.95, $fn=$fn_smooth);
        // Vestigial ears
        for (s=[-1,1]) translate([s*head_w/2, 0, head_h*0.04])
            scale([0.28, 1, 1]) sphere(d=15, $fn=$fn_smooth);
        // Neck plug
        translate([0, 0, -head_h/2 + 2]) cylinder(d=24, h=12);
    }
}

module head() {
    difference() {
        head_solid();
        // Face recess
        translate([0, head_d_front/2 - face_recess_depth + 1, head_h*0.05])
            rotate([90,0,0]) scale([1, 0.65, 1])
                cylinder(d=46, h=face_recess_depth*2.5, center=true, $fn=$fn_smooth);
        // Muzzle dimple
        translate([0, head_d_front/2 - face_recess_depth + 1, -head_h*0.12])
            rotate([90,0,0])
                cylinder(d=muzzle_d - 1, h=face_recess_depth*1.5, center=true);
        // Mic port hidden behind left ear
        translate([-head_w/2 - 5, 0, head_h*0.04])
            rotate([0,90,0]) cylinder(d=3, h=head_w);
        // Neck cavity
        translate([0,0,-head_h/2]) cylinder(d=18, h=20, center=true);
    }
}

// =====================================================================
//  FACE INSERTS
// =====================================================================

module eye_board() {
    eyeboard_t = face_recess_depth + 1.2;
    difference() {
        lozenge(eyeboard_w, eyeboard_h, eyeboard_t);
        for (s=[-1,1]) translate([s*eye_spacing/2, 0, -0.1])
            cylinder(d=eye_d - 0.2, h=eyeboard_t + 0.2);
    }
}

module muzzle() {
    muzzle_t = face_recess_depth + 0.5;
    hull() {
        cylinder(d=muzzle_d, h=muzzle_t*0.6);
        translate([0,0,muzzle_t*0.7]) cylinder(d=muzzle_d*0.7, h=muzzle_t*0.4);
    }
}

// =====================================================================
//  TORSO  (organic egg + flowing shoulder caps)
// =====================================================================

// Shoulder cap position in torso-local Z (relative to torso center)
shoulder_local_z = torso_h*0.32;

module torso_outer() {
    hull() {
        // Main torso column — taper from shoulder (wide) to hip (narrower)
        translate([0,0, torso_h*0.45]) ovoid(torso_w*0.85, torso_d*0.85, 4);
        translate([0,0, torso_h*0.20]) ovoid(torso_w*0.95, torso_d*0.95, 4);
        translate([0,0,-torso_h*0.10]) ovoid(torso_w*0.90, torso_d*0.95, 4);
        translate([0,0,-torso_h*0.45]) ovoid(torso_w*0.75, torso_d*0.80, 4);
        // Flowing shoulder caps — extend torso outward to meet arm root.
        // hull() with the rest creates a continuous swell, no clip-on look.
        for (s=[-1,1]) translate([s*torso_w*0.48, 0, shoulder_local_z])
            sphere(d=24, $fn=$fn_smooth);
    }
}

module torso_cavity() {
    hull() {
        translate([0,0, torso_h*0.45 - wall]) ovoid(torso_w*0.85 - 2*wall, torso_d*0.85 - 2*wall, 3);
        translate([0,0, torso_h*0.20]) ovoid(torso_w*0.95 - 2*wall, torso_d*0.95 - 2*wall, 3);
        translate([0,0,-torso_h*0.10]) ovoid(torso_w*0.90 - 2*wall, torso_d*0.95 - 2*wall, 3);
        translate([0,0,-torso_h*0.45 + wall]) ovoid(torso_w*0.75 - 2*wall, torso_d*0.80 - 2*wall, 3);
    }
}

module torso_base() {
    difference() {
        torso_outer();
        torso_cavity();
        // Neck socket
        translate([0,0, torso_h/2 - 6]) cylinder(d=24 + fit_loose, h=14);
        // Shoulder pin holes (through the shoulder caps)
        for (s=[-1,1]) translate([s*torso_w*0.48, 0, shoulder_local_z])
            rotate([0,90,0]) cylinder(d=shoulder_pin_d, h=30, center=true);
        // Bottom hatch — invisible when standing on base disc
        translate([0, 0, -torso_h/2 + 1])
            rounded_box(40 + fit_loose, 38 + fit_loose, 4, r=4);
        // Leg sockets — where leg pegs insert into torso bottom
        for (s=[-1,1]) translate([s*torso_w*0.18, 0, -torso_h/2 + 2])
            cylinder(d=14 + fit_loose, h=10, center=true);
        // Mic chamber opening
        translate([0,0, torso_h/2 - 6]) cylinder(d=14, h=20);
    }
    // Shoulder pin bosses (reinforcement around pin)
    for (s=[-1,1]) translate([s*torso_w*0.42, 0, shoulder_local_z])
        rotate([0,90,0]) difference() {
            cylinder(d=12, h=8, center=true);
            cylinder(d=shoulder_pin_d, h=10, center=true);
        }
}

// Curved seam: hidden by being on the left side of the body
seam_R = 220;
module torso_split_curved() {
    translate([0, seam_R - 1, 0])
        cylinder(r = seam_R, h = 400, center = true, $fn=128);
}

module torso_front() {
    intersection() {
        torso_base();
        torso_split_curved();
    }
}

module torso_back() {
    difference() {
        torso_base();
        torso_split_curved();
    }
    // ESP32 standoffs on inside back wall
    for (s=[-1,1])
        translate([s*(esp_w/2 - 3), -torso_d/2 + wall + 2, -torso_h*0.05])
            cylinder(d=5, h=4);
}

// Bottom plate (removable, magnetically held, hides ESP32 + USB access)
module bottom_plate() {
    plate_t = 3;
    difference() {
        union() {
            rounded_box(40, 38, plate_t, r=4);
            // Magnet pockets stand off (4 corners)
            for (xs=[-1,1], ys=[-1,1])
                translate([xs*14, ys*13, 0])
                    cylinder(d=8, h=plate_t, center=true);
        }
        // Magnet holes
        for (xs=[-1,1], ys=[-1,1])
            translate([xs*14, ys*13, -plate_t/2])
                cylinder(d=5.2, h=2.2);
        // USB-C pass-through (cable exits down through bottom)
        translate([0, -8, 0]) rounded_box(12, 7, 8, r=1.5);
    }
}

// =====================================================================
//  ARM  (single piece, Bojesen-long, organic taper, tendon channel)
// =====================================================================

module arm_finished(side=1) {
    difference() {
        // Organic taper: shoulder → bicep → elbow → wrist → hand
        tapered_limb([
            [0,                       22],  // shoulder ball (matches torso cap)
            [arm_total_l*0.05,        23],  // just below shoulder
            [arm_total_l*0.20,        24],  // bicep bulge
            [arm_total_l*0.42,        20],
            [arm_total_l*0.50,        21],  // elbow
            [arm_total_l*0.58,        19],
            [arm_total_l*0.78,        16],
            [arm_total_l*0.88,        15],  // wrist
            [arm_total_l - 9,         19]   // hand bulb
        ]);
        // Tendon channel
        translate([0, side*3, -1])
            cylinder(d=tendon_ch_d, h=arm_total_l*0.45);
        // Knot pocket
        translate([0, side*3, arm_total_l*0.35]) sphere(d=5);
        // Shoulder pin hole (perpendicular through arm root)
        translate([-15, 0, 0])
            rotate([0,90,0]) cylinder(d=shoulder_pin_d, h=30);
    }
}

// =====================================================================
//  LEG  (standing — straight tapered, foot forward)
// =====================================================================

module leg(side=1) {
    union() {
        // Hip peg (inserts into torso bottom socket)
        translate([0,0,leg_h - 3]) cylinder(d=13.5, h=10);
        // Thigh + shin in one continuous taper
        tapered_limb([
            [0,             24],  // foot bulb height start (foot top)
            [leg_h*0.10,    22],  // ankle
            [leg_h*0.35,    21],  // shin
            [leg_h*0.55,    22],  // mid-leg
            [leg_h*0.80,    24],  // thigh
            [leg_h,         26]   // hip
        ]);
        // Foot — forward bulb, slightly toed-out
        translate([0, 0, 0]) rotate([0,0,side*10])
            translate([0, 4, 0]) scale([1, 1.5, 0.85])
                sphere(d=24, $fn=$fn_smooth);
    }
}

// =====================================================================
//  BASE DISC  (wooden coaster — hides USB, stable foot)
// =====================================================================

module base_disc() {
    foot_recess_offset = torso_w*0.18;
    difference() {
        // Disc with rounded top edge
        hull() {
            translate([0,0,1]) cylinder(d=base_d, h=base_h-2);
            translate([0,0,base_h-1]) cylinder(d=base_d-3, h=0.5);
            translate([0,0,1]) cylinder(d=base_d, h=0.1);
            translate([0,0,0.5]) cylinder(d=base_d-1, h=0.1);
        }
        // Foot recesses — shallow ovals where the monkey's feet sit
        for (s=[-1,1]) translate([s*foot_recess_offset, 4, base_h - base_foot_recess + 0.1])
            scale([1, 1.5, 1]) cylinder(d=26, h=base_foot_recess + 1);
        // USB-C cable notch on side (rear)
        translate([0, -base_d/2 - 1, base_h/2])
            rotate([90,0,0]) rotate([0,0,0])
                rounded_box(base_usb_notch_w, base_usb_notch_h, 10, r=1.5);
        // Cable channel — from foot recess area to USB notch
        translate([0, -base_d/4, base_h/2])
            rotate([90,0,0])
                cylinder(d=base_usb_notch_h, h=base_d/2, center=false);
        // Magnet pockets on top to retain monkey (optional)
        for (s=[-1,1]) translate([s*foot_recess_offset, -4, base_h - 2])
            cylinder(d=5.2, h=2.2);
    }
}

// =====================================================================
//  YOKE & SERVO BRACKET
// =====================================================================

module yoke() {
    arm_len = 14;
    difference() {
        union() {
            cylinder(d=12, h=4);
            for (s=[-1,1]) translate([s*arm_len/2, 0, 2])
                cube([arm_len, 5, 4], center=true);
            for (s=[-1,1]) translate([s*arm_len, 0, 2])
                cylinder(d=5, h=4, center=true);
        }
        cylinder(d=5.0, h=10, center=true);
        for (s=[-1,1]) translate([s*arm_len, 0, 0])
            cylinder(d=tendon_ch_d, h=10);
    }
}

module servo_bracket() {
    plate_w = sg90_body_w + 14;
    plate_l = sg90_body_l + 12;
    plate_t = 3;
    bw = sg90_body_w + 0.6;
    bl = sg90_body_l + 0.6;
    bh = sg90_body_h;
    difference() {
        union() {
            cube([plate_w, plate_l, plate_t], center=true);
            translate([0, -bl/2 - 1.5, plate_t/2 + bh/2])
                cube([bw + 8, 3, bh], center=true);
            translate([0,  bl/2 + 1.5, plate_t/2 + bh/2])
                cube([bw + 8, 3, bh], center=true);
            for (s=[-1,1]) translate([s*(bw/2 + 1.5), 0, plate_t/2 + bh/2])
                cube([3, bl + 6, bh], center=true);
        }
        for (s=[-1,1]) translate([0, s*(sg90_body_l/2 + 3), 0])
            cylinder(d=2.2, h=plate_t + 4, center=true);
        for (x=[-1,1], y=[-1,1])
            translate([x*(plate_w/2 - 3), y*(plate_l/2 - 3), 0])
                cylinder(d=2.5, h=plate_t + 4, center=true);
    }
}

// =====================================================================
//  ASSEMBLY PREVIEWS  (standing pose, alert rest posture)
// =====================================================================

module assembly_preview() {
    // Base disc on ground
    color("peru") base_disc();
    // Legs — feet docked into base
    for (s=[-1,1])
        translate([s*torso_w*0.18, 4, base_h - base_foot_recess + foot_h])
            color("burlywood") leg(s);
    // Torso — sits on top of legs
    translate([0, 0, base_h + foot_h + leg_h - 2 + torso_h/2])
        color("burlywood") torso_base();
    // Head
    translate([0, 0, base_h + foot_h + leg_h + torso_h + head_h/2 - 8])
        color("burlywood") head();
    // Face inserts
    head_z = base_h + foot_h + leg_h + torso_h + head_h/2 - 8;
    translate([0, head_d_front/2 + 2, head_z + head_h*0.05])
        rotate([90,0,0]) color("saddlebrown") eye_board();
    translate([0, head_d_front/2 + 1, head_z - head_h*0.12])
        rotate([90,0,0]) color("saddlebrown") muzzle();
    // ARMS — alert rest posture: hanging slightly forward (-12° around X)
    shoulder_global_z = base_h + foot_h + leg_h - 2 + torso_h/2 + shoulder_local_z;
    for (s=[-1,1])
        translate([s*torso_w*0.48, 0, shoulder_global_z])
            rotate([180 - 12, 0, 0])  // hanging down, tilted slightly forward
                color("burlywood") arm_finished(s);
}

module triggered_preview() {
    color("peru") base_disc();
    for (s=[-1,1])
        translate([s*torso_w*0.18, 4, base_h - base_foot_recess + foot_h])
            color("burlywood") leg(s);
    translate([0, 0, base_h + foot_h + leg_h - 2 + torso_h/2])
        color("burlywood") torso_base();
    head_z = base_h + foot_h + leg_h + torso_h + head_h/2 - 8;
    translate([0, 0, head_z])
        color("burlywood") head();
    translate([0, head_d_front/2 + 2, head_z + head_h*0.05])
        rotate([90,0,0]) color("saddlebrown") eye_board();
    translate([0, head_d_front/2 + 1, head_z - head_h*0.12])
        rotate([90,0,0]) color("saddlebrown") muzzle();
    // Arms raised — rotated UP toward face. ~145° from rest position.
    shoulder_global_z = base_h + foot_h + leg_h - 2 + torso_h/2 + shoulder_local_z;
    for (s=[-1,1])
        translate([s*torso_w*0.48, 0, shoulder_global_z])
            rotate([30, 0, -s*15])  // arms up and inward toward face
                color("burlywood") arm_finished(s);
}

// =====================================================================
//  PART SELECTOR
// =====================================================================

if      (part == "head")          head();
else if (part == "eye_board")     eye_board();
else if (part == "muzzle")        muzzle();
else if (part == "torso_front")   torso_front();
else if (part == "torso_back")    torso_back();
else if (part == "bottom_plate")  bottom_plate();
else if (part == "arm_left")      arm_finished(-1);
else if (part == "arm_right")     arm_finished(1);
else if (part == "leg_left")      leg(-1);
else if (part == "leg_right")     leg(1);
else if (part == "base_disc")     base_disc();
else if (part == "yoke")          yoke();
else if (part == "servo_bracket") servo_bracket();
else if (part == "triggered")     triggered_preview();
else                              assembly_preview();
