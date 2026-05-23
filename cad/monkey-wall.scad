// =====================================================================
//  Aben — Wall variant (V1.0-wall)
//  ---------------------------------------------------------------------
//  Smaller wall-mounted variant. Target: ~125 mm tall total (including
//  dangling legs), under 4 h total print time, hangs from a keyhole on
//  the back of the torso.
//
//  Why wall-mount: Bojesen's monkey is iconic for *hanging* from things
//  — shelves, coat hooks, branches. Wall-mounting honours that heritage
//  and lets us eliminate the base disc entirely. The dangling-legs look
//  becomes a design feature instead of an awkward seated splay.
//
//  Constraints driving sizing:
//    * SG90 servo: 23 × 12.2 × 22.5 mm body → torso cavity must be
//      at least 27 × 17 × 28 mm internal → external floor ~32 × 22 × 33 mm.
//      Below this size, you need a smaller servo (SG51R or similar).
//    * Wall thickness 2.0 mm (slightly thinner than desktop variant).
//
//  Coordinate system: Z=0 at torso center, +Z up, +Y forward (out from
//  wall — face direction), +X right.
//
//  Units: millimetres.
// =====================================================================

part = "preview";   // "preview" | "triggered" | "midmotion" | "wall_mockup"
                    // | "head" | "torso_front" | "torso_back" | "bottom_plate"
                    // | "arm_left" | "arm_right" | "leg_left" | "leg_right"
                    // | "eye_board" | "muzzle" | "servo_bracket" | "yoke"

// ---------- DIMENSIONS (~55% of desktop) ----------
torso_h            = 52;                       // raised from 44 → gives mic (39.5 mm) real clearance
torso_w            = 38;
torso_d            = 28;
head_w             = 36;
head_h             = 40;
head_d_front       = 38;
leg_h              = 40;
leg_d              = 13;
arm_total_l        = 75;
shoulder_local_z   = torso_h * 0.32;

// ---------- FACE / DETAIL ----------
eyeboard_w         = 22;
eyeboard_h         = 8;
eye_d              = 3.5;
eye_spacing        = 11;
muzzle_d           = 8.5;
face_recess_depth  = 2;

// ---------- WALL & FIT ----------
wall               = 2.0;
fit_loose          = 0.4;
fit_tight          = 0.2;

// ---------- WALL MOUNT (keyhole on torso back) ----------
keyhole_circle_d   = 8;
keyhole_slot_w     = 2.8;
keyhole_slot_h     = 10;
keyhole_z          = torso_h * 0.25;

// ---------- MECHANISM ----------
sg90_body_l        = 23.0;
sg90_body_w        = 12.2;
sg90_body_h        = 22.5;
// ---------- COMPONENTS (matched to STLs in hardware/components/) ----------
// MCU: ESP32-C3 Super Mini — 22 × 18 × 8 mm. Only MCU that fits 44 mm torso.
esp_w              = 22;
esp_l              = 18;
esp_h              = 8;
// I2S mic board (matches hardware/components/microphone.stl) — vertical orientation
mic_w              = 40;
mic_d              = 11;
mic_h              = 20;
// USB-C breakout (matches hardware/components/usbc.stl)
usbc_w             = 20;
usbc_d             = 10;
usbc_h             = 20;
shoulder_pin_d     = 2.5;
tendon_ch_d        = 2.0;

// ---------- RESOLUTION ----------
$fa = 2;
$fs = 0.5;
$fn_smooth         = 80;

// =====================================================================
//  HELPERS
// =====================================================================

module ovoid(w, d, h) {
    scale([w/2, d/2, h/2]) sphere(r=1, $fn=$fn_smooth);
}

module rounded_box(w, d, h, r=2) {
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

module tapered_limb(points) {
    hull() for (p = points)
        translate([0, 0, p[0]]) sphere(d=p[1], $fn=$fn_smooth);
}

// =====================================================================
//  HEAD
// =====================================================================

module head_solid() {
    union() {
        ovoid(head_w, head_d_front, head_h);
        translate([0, head_d_front*0.04, -head_h*0.40])
            scale([0.85, 0.85, 0.7]) sphere(d=head_w*0.65, $fn=$fn_smooth);
        translate([0, head_d_front*0.16, head_h*0.05])
            scale([1, 0.55, 0.35]) sphere(d=head_w*0.95, $fn=$fn_smooth);
        for (s=[-1,1]) translate([s*head_w/2, 0, head_h*0.04])
            scale([0.28, 1, 1]) sphere(d=9, $fn=$fn_smooth);
        translate([0, 0, -head_h/2 + 2]) cylinder(d=14, h=8);
    }
}

module head() {
    difference() {
        head_solid();
        translate([0, head_d_front/2 - face_recess_depth + 0.5, head_h*0.05])
            rotate([90,0,0]) scale([1, 0.65, 1])
                cylinder(d=26, h=face_recess_depth*2.5, center=true, $fn=$fn_smooth);
        translate([0, head_d_front/2 - face_recess_depth + 0.5, -head_h*0.12])
            rotate([90,0,0])
                cylinder(d=muzzle_d - 0.5, h=face_recess_depth*1.5, center=true);
        translate([-head_w/2 - 3, 0, head_h*0.04])
            rotate([0,90,0]) cylinder(d=2.5, h=head_w);
        translate([0,0,-head_h/2]) cylinder(d=10, h=12, center=true);
    }
}

module eye_board() {
    eyeboard_t = face_recess_depth + 0.8;
    difference() {
        lozenge(eyeboard_w, eyeboard_h, eyeboard_t);
        for (s=[-1,1]) translate([s*eye_spacing/2, 0, -0.1])
            cylinder(d=eye_d - 0.2, h=eyeboard_t + 0.2);
    }
}

module muzzle() {
    muzzle_t = face_recess_depth + 0.3;
    hull() {
        cylinder(d=muzzle_d, h=muzzle_t*0.6);
        translate([0,0,muzzle_t*0.7]) cylinder(d=muzzle_d*0.7, h=muzzle_t*0.4);
    }
}

// =====================================================================
//  TORSO
// =====================================================================

module torso_outer() {
    hull() {
        translate([0,0, torso_h*0.45]) ovoid(torso_w*0.85, torso_d*0.85, 3);
        translate([0,0, torso_h*0.20]) ovoid(torso_w*0.95, torso_d*0.95, 3);
        translate([0,0,-torso_h*0.10]) ovoid(torso_w*0.90, torso_d*0.95, 3);
        translate([0,0,-torso_h*0.45]) ovoid(torso_w*0.75, torso_d*0.80, 3);
        for (s=[-1,1]) translate([s*torso_w*0.48, 0, shoulder_local_z])
            sphere(d=14, $fn=$fn_smooth);
    }
}

module torso_cavity() {
    hull() {
        translate([0,0, torso_h*0.45 - wall]) ovoid(torso_w*0.85 - 2*wall, torso_d*0.85 - 2*wall, 2);
        translate([0,0, torso_h*0.20]) ovoid(torso_w*0.95 - 2*wall, torso_d*0.95 - 2*wall, 2);
        translate([0,0,-torso_h*0.10]) ovoid(torso_w*0.90 - 2*wall, torso_d*0.95 - 2*wall, 2);
        translate([0,0,-torso_h*0.45 + wall]) ovoid(torso_w*0.75 - 2*wall, torso_d*0.80 - 2*wall, 2);
    }
}

module torso_base() {
    difference() {
        torso_outer();
        torso_cavity();
        translate([0,0, torso_h/2 - 4]) cylinder(d=14 + fit_loose, h=10);
        for (s=[-1,1]) translate([s*torso_w*0.48, 0, shoulder_local_z])
            rotate([0,90,0]) cylinder(d=shoulder_pin_d, h=20, center=true);
        translate([0, 0, -torso_h/2 + 0.5])
            rounded_box(24, 20, 3, r=3);
        for (s=[-1,1]) translate([s*torso_w*0.20, 0, -torso_h/2 + 2])
            cylinder(d=10 + fit_loose, h=8, center=true);
        translate([0,0, torso_h/2 - 4]) cylinder(d=9, h=12);
        translate([0, 0, -torso_h/2 + 1])
            rounded_box(11, 6, 4, r=1.5);
    }
    for (s=[-1,1]) translate([s*torso_w*0.40, 0, shoulder_local_z])
        rotate([0,90,0]) difference() {
            cylinder(d=7, h=6, center=true);
            cylinder(d=shoulder_pin_d, h=8, center=true);
        }
}

module keyhole_cutter() {
    translate([0, -torso_d/2 - 0.1, keyhole_z]) {
        rotate([90, 0, 0]) {
            cylinder(d=keyhole_circle_d, h=4, center=true);
            translate([0, -keyhole_slot_h/2 - keyhole_circle_d/2 + 1, 0])
                cube([keyhole_slot_w, keyhole_slot_h, 4], center=true);
        }
        translate([0, 0.6, 0])
            rotate([90, 0, 0]) {
                cylinder(d=keyhole_circle_d + 4, h=2, center=true);
                translate([0, -keyhole_slot_h/2 - keyhole_circle_d/2 + 1, 0])
                    cube([keyhole_slot_w + 3, keyhole_slot_h, 2], center=true);
            }
    }
}

seam_R = 120;
module torso_split_curved() {
    translate([0, seam_R - 0.5, 0])
        cylinder(r = seam_R, h = 200, center = true, $fn=128);
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
        keyhole_cutter();
    }
    for (s=[-1,1])
        translate([s*8, -torso_d/2 + wall + 1, 0])
            cylinder(d=4, h=3);
}

module bottom_plate() {
    plate_t = 2;
    difference() {
        rounded_box(24, 20, plate_t, r=3);
        translate([0, 0, -plate_t/2])
            cylinder(d=5.2, h=2.2);
        // Cable bundle cutout — USB-C + mic wires + motor wires going down to hub
        translate([0, 0, 0]) rounded_box(14, 8, 4, r=1.5);
    }
}

// =====================================================================
//  ARM
// =====================================================================

// ---------------------------------------------------------------------
// 2-PIECE ARM (V1.1) — upper arm + forearm joined at the elbow by a
// 2 mm pin. Tendon passes through both pieces. When the servo pulls
// the tendon, BOTH pieces rotate forward simultaneously, folding the
// arm at the elbow so the hand lands at muzzle height in front of the
// face — the actual "shh" gesture.
//
// At rest, gravity + slight elastic return holds the forearm pointing
// straight down, making the arm read as a single hanging limb.
//
// Parts: upper_arm_left/right + forearm_left/right + arm uses a 2 mm
// steel pin (15 mm long) at the elbow.
// ---------------------------------------------------------------------

elbow_pin_d        = 2.2;     // 2 mm pin + clearance

module upper_arm(side=1) {
    upper_l = arm_total_l * 0.5;       // 37.5 mm for wall
    difference() {
        // Tapered upper arm — shoulder ball to elbow knuckle
        tapered_limb([
            [0,           14],          // shoulder ball
            [upper_l*0.2, 15],          // shoulder cap
            [upper_l*0.5, 13],          // mid-bicep
            [upper_l*0.8, 12],          // toward elbow
            [upper_l,     13]           // elbow knuckle (slightly bulb)
        ]);
        // Shoulder pin hole — driven by servo via tendon
        translate([-10, 0, 0])
            rotate([0,90,0]) cylinder(d=shoulder_pin_d, h=20);
        // Elbow pin hole — through-bore for the 2 mm hinge pin
        translate([-10, 0, upper_l])
            rotate([0,90,0]) cylinder(d=elbow_pin_d, h=20);
        // Tendon channel — runs the length of the upper arm,
        // exits the front face just below the elbow so it can be
        // routed across the joint to the forearm.
        translate([0, side*2, -1])
            cylinder(d=tendon_ch_d, h=upper_l - 2);
        // Forearm-clearance slot — flattens the elbow front-face so
        // the forearm's top sphere has room to fold against the upper
        // arm without binding.
        translate([0, 5, upper_l + 1])
            cube([16, 8, 6], center=true);
    }
}

module forearm(side=1) {
    fore_l = arm_total_l * 0.5;        // 37.5 mm for wall
    difference() {
        // Tapered forearm — elbow knuckle to hand
        tapered_limb([
            [0,            13],         // elbow knuckle (matches upper)
            [fore_l*0.2,   12],
            [fore_l*0.5,   10],         // slim forearm middle
            [fore_l*0.8,    9],
            [fore_l - 5,   11],         // wrist
            [fore_l,       14]          // hand sphere (palm-cup)
        ]);
        // Elbow pin hole — mates with upper arm's hole
        translate([-10, 0, 0])
            rotate([0,90,0]) cylinder(d=elbow_pin_d, h=20);
        // Tendon channel — enters near elbow front, runs ~60% down
        // the forearm to a knot pocket where the line is secured.
        translate([0, -side*2, 2])
            cylinder(d=tendon_ch_d, h=fore_l*0.55);
        // Knot pocket for tendon termination — small sphere cut-out
        // so the knot has room to seat.
        translate([0, -side*2, fore_l*0.55 + 2])
            sphere(d=3.5);
        // Upper-arm-clearance — slight bevel at the top-back so the
        // forearm can swing forward freely without scraping the upper.
        translate([0, -6, -2])
            rotate([45, 0, 0])
                cube([16, 6, 6], center=true);
    }
}

// Legacy single-piece arm — kept for backward compatibility and as a
// reference for renders. Not used in V1.1 build.
module arm_finished(side=1) {
    difference() {
        tapered_limb([
            [0,                       13],
            [arm_total_l*0.05,        14],
            [arm_total_l*0.20,        15],
            [arm_total_l*0.42,        12],
            [arm_total_l*0.50,        13],
            [arm_total_l*0.58,        11],
            [arm_total_l*0.78,        10],
            [arm_total_l*0.88,        9],
            [arm_total_l - 5,         12]
        ]);
        translate([0, side*2, -1])
            cylinder(d=tendon_ch_d, h=arm_total_l*0.45);
        translate([0, side*2, arm_total_l*0.35]) sphere(d=3);
        translate([-10, 0, 0])
            rotate([0,90,0]) cylinder(d=shoulder_pin_d, h=20);
    }
}

// =====================================================================
//  LEG
// =====================================================================

module leg(side=1) {
    union() {
        translate([0,0,leg_h - 3]) cylinder(d=10, h=8);
        tapered_limb([
            [0,           14],
            [leg_h*0.15,  12],
            [leg_h*0.50,  12],
            [leg_h*0.80,  14],
            [leg_h,       15]
        ]);
        translate([0, 2, 1]) scale([1, 1.3, 0.85])
            sphere(d=13, $fn=$fn_smooth);
    }
}

// =====================================================================
//  YOKE & SERVO BRACKET
// =====================================================================

module yoke() {
    arm_len = 10;
    difference() {
        union() {
            cylinder(d=8, h=3);
            for (s=[-1,1]) translate([s*arm_len/2, 0, 1.5])
                cube([arm_len, 4, 3], center=true);
            for (s=[-1,1]) translate([s*arm_len, 0, 1.5])
                cylinder(d=4, h=3, center=true);
        }
        cylinder(d=5.0, h=8, center=true);
        for (s=[-1,1]) translate([s*arm_len, 0, 0])
            cylinder(d=tendon_ch_d, h=8);
    }
}

module servo_bracket() {
    plate_w = sg90_body_w + 10;
    plate_l = sg90_body_l + 8;
    plate_t = 2.5;
    bw = sg90_body_w + 0.6;
    bl = sg90_body_l + 0.6;
    bh = sg90_body_h;
    difference() {
        union() {
            cube([plate_w, plate_l, plate_t], center=true);
            translate([0, -bl/2 - 1.2, plate_t/2 + bh/2])
                cube([bw + 6, 2.4, bh], center=true);
            translate([0,  bl/2 + 1.2, plate_t/2 + bh/2])
                cube([bw + 6, 2.4, bh], center=true);
            for (s=[-1,1]) translate([s*(bw/2 + 1.2), 0, plate_t/2 + bh/2])
                cube([2.4, bl + 5, bh], center=true);
        }
        for (s=[-1,1]) translate([0, s*(sg90_body_l/2 + 3), 0])
            cylinder(d=2.0, h=plate_t + 4, center=true);
        for (x=[-1,1], y=[-1,1])
            translate([x*(plate_w/2 - 2.5), y*(plate_l/2 - 2.5), 0])
                cylinder(d=2.2, h=plate_t + 4, center=true);
    }
}

// =====================================================================
//  ASSEMBLY PREVIEWS
// =====================================================================

module assembly_preview() {
    color("burlywood") torso_base();
    translate([0, 0, torso_h/2 + head_h/2 - 4])
        color("burlywood") head();
    head_z = torso_h/2 + head_h/2 - 4;
    translate([0, head_d_front/2 + 1, head_z + head_h*0.05])
        rotate([90,0,0]) color("saddlebrown") eye_board();
    translate([0, head_d_front/2 + 0.5, head_z - head_h*0.12])
        rotate([90,0,0]) color("saddlebrown") muzzle();
    for (s=[-1,1])
        translate([s*torso_w*0.20, 0, -torso_h/2 - leg_h + 8])
            color("burlywood") leg(s);
    for (s=[-1,1])
        translate([s*torso_w*0.48, 0, shoulder_local_z])
            rotate([180 + 8, 0, 0])
                color("burlywood") arm_finished(s);
}

module triggered_preview() {
    color("burlywood") torso_base();
    head_z = torso_h/2 + head_h/2 - 4;
    translate([0, 0, head_z]) color("burlywood") head();
    translate([0, head_d_front/2 + 1, head_z + head_h*0.05])
        rotate([90,0,0]) color("saddlebrown") eye_board();
    translate([0, head_d_front/2 + 0.5, head_z - head_h*0.12])
        rotate([90,0,0]) color("saddlebrown") muzzle();
    for (s=[-1,1])
        translate([s*torso_w*0.20, 0, -torso_h/2 - leg_h + 8])
            color("burlywood") leg(s);
    for (s=[-1,1])
        translate([s*torso_w*0.48, 0, shoulder_local_z])
            rotate([35, 0, -s*15])
                color("burlywood") arm_finished(s);
}

module midmotion_preview() {
    color("burlywood") torso_base();
    head_z = torso_h/2 + head_h/2 - 4;
    translate([0, 0, head_z]) color("burlywood") head();
    translate([0, head_d_front/2 + 1, head_z + head_h*0.05])
        rotate([90,0,0]) color("saddlebrown") eye_board();
    translate([0, head_d_front/2 + 0.5, head_z - head_h*0.12])
        rotate([90,0,0]) color("saddlebrown") muzzle();
    for (s=[-1,1])
        translate([s*torso_w*0.20, 0, -torso_h/2 - leg_h + 8])
            color("burlywood") leg(s);
    for (s=[-1,1])
        translate([s*torso_w*0.48, 0, shoulder_local_z])
            rotate([110, 0, -s*10])
                color("burlywood") arm_finished(s);
}

module wall_mockup() {
    color([0.93, 0.90, 0.83])
        translate([-55, -torso_d/2 - 3, -90])
            cube([110, 2, 200]);
    assembly_preview();
    color("dimgray")
        translate([0, -torso_d/2 - 1.0, keyhole_z + 0.5])
            rotate([90,0,0]) cylinder(d=keyhole_circle_d-1, h=1);
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
else if (part == "upper_arm_left")  upper_arm(-1);
else if (part == "upper_arm_right") upper_arm(1);
else if (part == "forearm_left")    forearm(-1);
else if (part == "forearm_right")   forearm(1);
else if (part == "leg_left")      leg(-1);
else if (part == "leg_right")     leg(1);
else if (part == "yoke")          yoke();
else if (part == "servo_bracket") servo_bracket();
else if (part == "triggered")     triggered_preview();
else if (part == "midmotion")     midmotion_preview();
else if (part == "wall_mockup")   wall_mockup();
else                              assembly_preview();
