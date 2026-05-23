// =====================================================================
//  Aben — parametric Bojesen-tribute monkey, print-ready
//  ---------------------------------------------------------------------
//  Design philosophy: as simple as possible, as beautifully shaped as
//  pure parametric geometry can be.
//
//    * Organic taper via hull-of-spheres on every limb and the head
//      (this is what gives it the warm Bojesen feel, not engineered cuts)
//    * Curved torso seam — invisible from front and back
//    * Soft chin transition — no flat cut
//    * Single-piece arms — fewer parts, faster print, easier assembly
//    * 9 printable parts total
//
//  Render one part at a time with:
//    openscad -o out.stl -D 'part="head"' monkey.scad
//
//  Units: millimetres.
// =====================================================================

part = "preview";   // "preview" | "head" | "torso_front" | "torso_back"
                    // | "arm_left" | "arm_right" | "leg_left" | "leg_right"
                    // | "eye_board" | "muzzle" | "servo_bracket" | "yoke"

// ---------- DIMENSIONS ----------
torso_h            = 80;
torso_w            = 70;
torso_d            = 55;
head_w             = 66;
head_h             = 72;
head_d_front       = 70;
leg_total_l        = 90;
arm_total_l        = 110;

eyeboard_w         = 38;
eyeboard_h         = 14;
eye_d              = 6;
eye_spacing        = 19;
muzzle_d           = 15;
face_recess_depth  = 3.5;

wall               = 2.4;
fit_loose          = 0.4;

// SG90 servo nominal
sg90_body_l        = 23.0;
sg90_body_w        = 12.2;
sg90_body_h        = 22.5;

esp_w              = 28;
esp_l              = 65;
shoulder_pin_d     = 3.2;
tendon_ch_d        = 2.4;

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
        // Subtle brow-forward (gives the face presence, not cartoony)
        translate([0, head_d_front*0.16, head_h*0.05])
            scale([1, 0.55, 0.35]) sphere(d=head_w*0.95, $fn=$fn_smooth);
        // Vestigial ears (shallow ovoids, not flat discs)
        for (s=[-1,1]) translate([s*head_w/2, 0, head_h*0.04])
            scale([0.28, 1, 1]) sphere(d=15, $fn=$fn_smooth);
        // Neck plug
        translate([0, 0, -head_h/2 + 2]) cylinder(d=24, h=12);
    }
}

module head() {
    difference() {
        head_solid();
        // Face recess for eye-board + muzzle press-fit
        translate([0, head_d_front/2 - face_recess_depth + 1, head_h*0.05])
            rotate([90,0,0]) scale([1, 0.65, 1])
                cylinder(d=46, h=face_recess_depth*2.5, center=true, $fn=$fn_smooth);
        // Subtle muzzle dimple
        translate([0, head_d_front/2 - face_recess_depth + 1, -head_h*0.12])
            rotate([90,0,0])
                cylinder(d=muzzle_d - 1, h=face_recess_depth*1.5, center=true);
        // Mic port hidden behind LEFT ear (out of sight from front)
        translate([-head_w/2 - 5, 0, head_h*0.04])
            rotate([0,90,0]) cylinder(d=3, h=head_w);
        // Neck cavity (acoustic path)
        translate([0,0,-head_h/2]) cylinder(d=18, h=20, center=true);
    }
}

// =====================================================================
//  FACE INSERTS  (dark filament, press-fit)
// =====================================================================

module eye_board() {
    eyeboard_t = face_recess_depth + 1.2;
    difference() {
        lozenge(eyeboard_w, eyeboard_h, eyeboard_t);
        // Two clean round eye holes for 6mm black glass beads
        for (s=[-1,1]) translate([s*eye_spacing/2, 0, -0.1])
            cylinder(d=eye_d - 0.2, h=eyeboard_t + 0.2);
    }
}

module muzzle() {
    muzzle_t = face_recess_depth + 0.5;
    // Slightly domed — not a flat puck
    hull() {
        cylinder(d=muzzle_d, h=muzzle_t*0.6);
        translate([0,0,muzzle_t*0.7]) cylinder(d=muzzle_d*0.7, h=muzzle_t*0.4);
    }
}

// =====================================================================
//  TORSO  (organic egg shape, curved seam)
// =====================================================================

module torso_outer() {
    hull() {
        translate([0,0, torso_h*0.45]) ovoid(torso_w*0.80, torso_d*0.80, 4);
        translate([0,0, torso_h*0.15]) ovoid(torso_w*0.98, torso_d*0.95, 4);
        translate([0,0,-torso_h*0.20]) ovoid(torso_w*1.00, torso_d*1.00, 4);
        translate([0,0,-torso_h*0.45]) ovoid(torso_w*0.85, torso_d*0.85, 4);
    }
}

module torso_cavity() {
    hull() {
        translate([0,0, torso_h*0.45 - wall]) ovoid(torso_w*0.80 - 2*wall, torso_d*0.80 - 2*wall, 3);
        translate([0,0, torso_h*0.15]) ovoid(torso_w*0.98 - 2*wall, torso_d*0.95 - 2*wall, 3);
        translate([0,0,-torso_h*0.20]) ovoid(torso_w - 2*wall, torso_d - 2*wall, 3);
        translate([0,0,-torso_h*0.45 + wall]) ovoid(torso_w*0.85 - 2*wall, torso_d*0.85 - 2*wall, 3);
    }
}

module torso_base() {
    difference() {
        torso_outer();
        torso_cavity();
        // Neck socket
        translate([0,0, torso_h/2 - 6]) cylinder(d=24 + fit_loose, h=14);
        // Shoulder pin holes
        for (s=[-1,1]) translate([s*(torso_w/2 - 3), 0, torso_h*0.30])
            rotate([0,90,0]) cylinder(d=shoulder_pin_d, h=24, center=true);
        // Back hatch
        translate([0, -torso_d/2, -torso_h*0.15])
            rounded_box(40 + fit_loose, 6, 60 + fit_loose, r=3);
        // USB-C cutout
        translate([0, -torso_d/2, -torso_h*0.42])
            rounded_box(12, 6, 7, r=1.5);
        // Mic chamber opening
        translate([0,0, torso_h/2 - 6]) cylinder(d=14, h=20);
    }
    // Shoulder bosses (reinforced rings)
    for (s=[-1,1]) translate([s*(torso_w/2 - 6), 0, torso_h*0.30])
        rotate([0,90,0]) difference() {
            cylinder(d=11, h=8, center=true);
            cylinder(d=shoulder_pin_d, h=10, center=true);
        }
}

// Curved seam: gentle cylinder cut, makes the split nearly invisible
seam_R = 200;
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
    // Magnet pockets for back hatch (4× 5mm round neodymium)
    for (xs=[-1,1], zs=[-1,1])
        translate([xs*16, -torso_d/2 + wall, -torso_h*0.15 + zs*22])
            rotate([90,0,0]) cylinder(d=5.2, h=2.2);
}

// =====================================================================
//  ARM  (single piece, organic taper, tendon channel)
// =====================================================================

module arm_finished(side=1) {
    difference() {
        union() {
            // Organic taper from shoulder to hand
            tapered_limb([
                [0,                       22],  // shoulder
                [arm_total_l*0.18,        23],  // bicep
                [arm_total_l*0.42,        19],
                [arm_total_l*0.50,        20],  // elbow
                [arm_total_l*0.58,        19],
                [arm_total_l*0.85,        16],  // wrist
                [arm_total_l - 8,         18]   // hand bulb
            ]);
        }
        // Tendon channel (from shoulder anchor up the inside of upper arm)
        translate([0, side*3, -1])
            cylinder(d=tendon_ch_d, h=arm_total_l*0.45);
        // Tendon knot pocket
        translate([0, side*3, arm_total_l*0.35]) sphere(d=5);
        // Shoulder pin hole (perpendicular through arm base)
        translate([-15, 0, 4])
            rotate([0,90,0]) cylinder(d=shoulder_pin_d, h=30);
    }
}

// =====================================================================
//  LEG  (organic taper, bent for seated pose)
// =====================================================================

module leg(side=1) {
    thigh_l = leg_total_l * 0.50;
    shin_l  = leg_total_l * 0.50;
    union() {
        // Thigh
        tapered_limb([
            [0,           28],  // hip
            [thigh_l*0.3, 26],
            [thigh_l*0.7, 24],
            [thigh_l,     25]   // knee
        ]);
        // Knee bulge
        translate([0,0,thigh_l]) sphere(d=27, $fn=$fn_smooth);
        // Shin (angled forward for seated pose)
        translate([0,0,thigh_l]) rotate([78, 0, 0]) {
            tapered_limb([
                [0,          24],
                [shin_l*0.4, 22],
                [shin_l*0.8, 20],
                [shin_l,     24]
            ]);
            // Foot
            translate([0, 5, shin_l]) scale([1, 1.4, 0.85])
                sphere(d=22, $fn=$fn_smooth);
        }
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
        cylinder(d=5.0, h=10, center=true);  // servo spline
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
            // Servo cradle walls
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
//  ASSEMBLY PREVIEWS
// =====================================================================

module assembly_preview() {
    color("burlywood") torso_base();
    translate([0, 0, torso_h/2 + head_h/2 - 8])
        color("burlywood") head();
    translate([0, head_d_front/2 + 2, torso_h/2 + head_h/2 - 8 + head_h*0.05])
        rotate([90,0,0]) color("saddlebrown") eye_board();
    translate([0, head_d_front/2 + 1, torso_h/2 + head_h/2 - 8 - head_h*0.12])
        rotate([90,0,0]) color("saddlebrown") muzzle();
    // Arms at rest
    for (s=[-1,1]) translate([s*(torso_w/2 - 4), 0, torso_h*0.30])
        rotate([175, 0, 0])
            color("burlywood") arm_finished(s);
    // Legs seated
    for (s=[-1,1]) translate([s*(torso_w/3), -2, -torso_h/2 + 8])
        rotate([90, 0, 0])
            color("burlywood") leg(s);
}

module triggered_preview() {
    color("burlywood") torso_base();
    translate([0, 0, torso_h/2 + head_h/2 - 8])
        color("burlywood") head();
    translate([0, head_d_front/2 + 2, torso_h/2 + head_h/2 - 8 + head_h*0.05])
        rotate([90,0,0]) color("saddlebrown") eye_board();
    translate([0, head_d_front/2 + 1, torso_h/2 + head_h/2 - 8 - head_h*0.12])
        rotate([90,0,0]) color("saddlebrown") muzzle();
    // Arms raised — hands at eye level
    for (s=[-1,1]) translate([s*(torso_w/2 - 4), 0, torso_h*0.30])
        rotate([95, 0, -s*8])
            color("burlywood") arm_finished(s);
    for (s=[-1,1]) translate([s*(torso_w/3), -2, -torso_h/2 + 8])
        rotate([90, 0, 0])
            color("burlywood") leg(s);
}

// =====================================================================
//  PART SELECTOR
// =====================================================================

if      (part == "head")          head();
else if (part == "eye_board")     eye_board();
else if (part == "muzzle")        muzzle();
else if (part == "torso_front")   torso_front();
else if (part == "torso_back")    torso_back();
else if (part == "arm_left")      arm_finished(-1);
else if (part == "arm_right")     arm_finished(1);
else if (part == "leg_left")      leg(-1);
else if (part == "leg_right")     leg(1);
else if (part == "yoke")          yoke();
else if (part == "servo_bracket") servo_bracket();
else if (part == "triggered")     triggered_preview();
else                              assembly_preview();
