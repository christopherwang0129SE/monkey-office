// =====================================================================
//  Hør-ikke-abe — parametric monkey, V0 engineering mockup
//  ---------------------------------------------------------------------
//  Single-file parametric model. Render one part at a time by setting
//  the `part` variable below (or via -D 'part="head"' on the CLI).
//
//  Honest scope of this file:
//    * Proportions, stance, mechanism mounts, assembly fit  → DONE
//    * Organic Bojesen-quality surfacing                   → OUT OF SCOPE
//      (do that in Blender/ZBrush, or fork a CC-licensed STL,
//       then re-import the body as a mesh and union the printed
//       mechanism mounts from this file into it)
//
//  Units: millimetres throughout.
// =====================================================================

// ---------- WHAT TO RENDER ----------
// Override with: openscad -o out.stl -D 'part="head"' monkey.scad
part = "preview";   // "preview" | "head" | "torso_front" | "torso_back"
                    // | "arm_left" | "arm_right" | "leg_left" | "leg_right"
                    // | "eye_board" | "muzzle" | "servo_bracket" | "yoke"

// ---------- GLOBAL DIMENSIONS (from design-v1.md §1) ----------
total_h            = 220;    // overall seated height
head_d             = 70;     // head sphere diameter
torso_h            = 80;     // torso height
torso_w            = 70;     // torso width (shoulder to shoulder)
torso_d            = 55;     // torso depth (chest to back)
leg_h              = 70;     // leg length when folded for seated pose
leg_d              = 22;     // leg diameter mid-shaft
arm_l              = 110;    // arm length, shoulder pin to fingertip
arm_d_shoulder     = 20;     // arm diameter at shoulder
arm_d_hand         = 16;     // arm diameter at hand
ear_d              = 14;     // ear disc diameter
ear_t              = 3;      // ear disc thickness

// ---------- FACE INSERTS ----------
face_recess_depth  = 3;
eyeboard_w         = 36;
eyeboard_h         = 14;
eyeboard_t         = face_recess_depth + 1; // proud of recess by 1mm
eye_d              = 6;      // black glass bead diameter
eye_spacing        = 18;     // centre-to-centre
muzzle_d           = 14;
muzzle_t           = face_recess_depth + 0.5;

// ---------- WALL & FIT ----------
wall               = 2.4;    // FDM wall thickness
fit_loose          = 0.4;    // diametral clearance for press fits
fit_tight          = 0.2;    // diametral clearance for snap fits

// ---------- MECHANISM (SG90 servo nominal) ----------
sg90_body_l        = 23.0;
sg90_body_w        = 12.2;
sg90_body_h        = 22.5;
sg90_tab_overhang  = 4.7;    // each side
sg90_tab_h         = 2.6;
sg90_tab_z         = 16.0;   // from bottom of body to top of tab
sg90_shaft_d       = 4.8;
sg90_shaft_off_x   = 5.8;    // shaft x-offset from body centre

// ---------- ESP32-S3 DEV BOARD nominal ----------
esp_w              = 28;
esp_l              = 65;
esp_t              = 1.6;
esp_clearance_all  = 1.0;

// ---------- TENDON CHANNELS ----------
tendon_ch_d        = 2.4;    // 2mm braided line + clearance

// ---------- RESOLUTION ----------
$fa = 2;
$fs = 0.6;

// =====================================================================
//  HELPERS
// =====================================================================

module ovoid(w, d, h) {
    // Egg / squashed sphere centred on origin
    scale([w/2, d/2, h/2]) sphere(r = 1);
}

module rounded_box(w, d, h, r=3) {
    hull() {
        for (x=[-1,1], y=[-1,1], z=[-1,1])
            translate([x*(w/2-r), y*(d/2-r), z*(h/2-r)]) sphere(r);
    }
}

module lozenge(w, h, t) {
    // Horizontal lozenge for eye-board: two hemispheres joined
    hull() {
        translate([-(w-h)/2, 0, 0]) cylinder(d=h, h=t, center=false);
        translate([ (w-h)/2, 0, 0]) cylinder(d=h, h=t, center=false);
    }
}

// =====================================================================
//  HEAD  (sphere + flat chin + face recess + ears + neck plug)
// =====================================================================

module head() {
    difference() {
        union() {
            // Main sphere
            sphere(d=head_d);
            // Vestigial ears
            for (s=[-1,1]) translate([s*head_d/2, 0, 0])
                rotate([0,s*90,0]) cylinder(d=ear_d, h=ear_t, center=true);
            // Neck plug (slots into torso top)
            translate([0,0,-head_d/2 + 4])
                cylinder(d=24, h=10);
        }
        // Flat chin cut (bottom 8mm of head removed for stable print)
        translate([0,0,-head_d]) cube([head_d*2, head_d*2, head_d-4], center=true);
        // Face recess
        translate([0, head_d/2 - face_recess_depth, head_d*0.04])
            rotate([90,0,0])
            scale([1, 0.65, 1])
                cylinder(d=44, h=face_recess_depth*2, center=true);
        // Mic sound port (3mm hole through face into head cavity)
        translate([0, head_d/2 - face_recess_depth - 2, head_d*0.04])
            rotate([90,0,0]) cylinder(d=3, h=head_d, center=false);
        // Neck cavity (sound path down to torso mic)
        translate([0,0,-head_d/2])
            cylinder(d=18, h=20, center=true);
    }
}

// =====================================================================
//  EYE-BOARD INSERT  (darker filament, press-fits into face recess)
// =====================================================================

module eye_board() {
    difference() {
        lozenge(eyeboard_w, eyeboard_h, eyeboard_t);
        // Two 5.8mm holes for 6mm black bead eyes (press fit)
        for (s=[-1,1]) translate([s*eye_spacing/2, 0, -0.1])
            cylinder(d=eye_d - 0.2, h=eyeboard_t + 0.2);
    }
}

// =====================================================================
//  MUZZLE INSERT  (darker filament, small disc below eye-board)
// =====================================================================

module muzzle() {
    cylinder(d=muzzle_d, h=muzzle_t);
}

// =====================================================================
//  TORSO  (egg-section, split front/back, internal mounts)
// =====================================================================

module torso_outer() {
    // Egg shape: ovoid with slight upward taper
    hull() {
        translate([0,0,torso_h*0.45]) ovoid(torso_w*0.85, torso_d*0.85, 6);
        translate([0,0,-torso_h*0.45]) ovoid(torso_w, torso_d, 6);
    }
}

module torso_cavity() {
    // Hollow inside, leaving walls of `wall` thickness
    hull() {
        translate([0,0,torso_h*0.45 - wall]) ovoid(torso_w*0.85 - 2*wall, torso_d*0.85 - 2*wall, 4);
        translate([0,0,-torso_h*0.45 + wall]) ovoid(torso_w - 2*wall, torso_d - 2*wall, 4);
    }
}

module torso_solid() {
    // Solid torso with cavity, shoulder pin bosses, neck socket, back hatch cutout
    difference() {
        torso_outer();
        torso_cavity();
        // Neck socket (top of torso accepts head neck plug + fit_loose)
        translate([0,0, torso_h/2 - 6])
            cylinder(d=24 + fit_loose, h=12, center=false);
        // Shoulder pin holes (3mm pins through arm + torso)
        for (s=[-1,1]) translate([s*(torso_w/2 - 3), 0, torso_h*0.32])
            rotate([0,90,0]) cylinder(d=3.2, h=20, center=true);
        // Back access hatch cutout (40x60 magnetic panel at lower back)
        translate([0, -torso_d/2, -torso_h*0.15])
            rounded_box(40 + fit_loose, 6, 60 + fit_loose, r=3);
        // USB-C cutout at bottom of back (low)
        translate([0, -torso_d/2, -torso_h*0.42])
            rounded_box(12, 6, 7, r=1.5);
        // Mic sound path opening to neck cavity
        translate([0,0, torso_h/2 - 6]) cylinder(d=14, h=20, center=false);
    }
    // Shoulder pin bosses (reinforced ring around the pin hole)
    for (s=[-1,1]) translate([s*(torso_w/2 - 4), 0, torso_h*0.32])
        rotate([0,90,0]) difference() {
            cylinder(d=10, h=6, center=true);
            cylinder(d=3.2, h=8, center=true);
        }
}

module torso_split_plane(thickness=1) {
    // Cuts torso into front + back along Y=0 with a slight curve
    // Approximation: just Y=0 flat plane for V0
    translate([0, -50, 0]) cube([200, 100, 200], center=true);
}

module torso_front() {
    difference() {
        torso_solid();
        torso_split_plane();
    }
    // Servo mounting ribs (front-half cradle for SG90)
    translate([0, 6, -2]) servo_cradle();
}

module torso_back() {
    intersection() {
        torso_solid();
        torso_split_plane();
    }
    // ESP32 mounting standoffs on inside of back
    for (s=[-1,1]) translate([s*(esp_w/2 - 3), -torso_d/2 + wall + 2, -torso_h*0.05 + s*15])
        cylinder(d=5, h=4);
}

// Servo cradle: holds SG90 vertically, shaft pointing up
module servo_cradle() {
    bw = sg90_body_w + 0.6;
    bl = sg90_body_l + 0.6;
    bh = sg90_body_h;
    // Two L-shaped ribs hugging the body
    difference() {
        translate([0,0,0]) {
            // Front wall
            translate([0, -bl/2 - 2, bh/2])
                cube([bw + 6, 2, bh], center=true);
            // Back wall
            translate([0,  bl/2 + 2, bh/2])
                cube([bw + 6, 2, bh], center=true);
        }
    }
    // Side rails with tab supports
    for (s=[-1,1]) translate([s*(bw/2 + 1), 0, bh/2])
        cube([2, bl + 4, bh], center=true);
}

// =====================================================================
//  ARM  (single piece, taper, sculpted elbow ring, tendon channel)
// =====================================================================

module arm(side=1) {
    // side: +1 = right (arm on +X), -1 = left
    // Built lying along +Z, shoulder at origin
    elbow_z = arm_l * 0.5;
    union() {
        // Upper arm
        hull() {
            cylinder(d=arm_d_shoulder, h=0.1);
            translate([0,0,elbow_z - 2]) cylinder(d=arm_d_shoulder*0.9, h=0.1);
        }
        // Elbow detail ring (sculpted joint, not functional)
        translate([0,0,elbow_z - 2])
            cylinder(d=arm_d_shoulder + 1, h=4);
        // Forearm
        hull() {
            translate([0,0,elbow_z + 2]) cylinder(d=arm_d_shoulder*0.9, h=0.1);
            translate([0,0,arm_l - arm_d_hand/2]) cylinder(d=arm_d_hand, h=0.1);
        }
        // Hand (rounded stub)
        translate([0,0,arm_l - arm_d_hand/2])
            sphere(d=arm_d_hand);
    }
}

module arm_with_channel(side=1) {
    difference() {
        arm(side);
        // Tendon channel: from shoulder anchor point up through arm
        translate([0, side*3, -1])
            cylinder(d=tendon_ch_d, h=arm_l*0.4);
        // Shoulder pin hole (3mm through-hole at base)
        translate([-15, 0, arm_d_shoulder*0.2])
            rotate([0,90,0]) cylinder(d=3.2, h=30);
        // Tendon termination cavity (knot pocket) inside upper arm
        translate([0, side*3, arm_l*0.35])
            sphere(d=5);
    }
}

// =====================================================================
//  LEG  (seated pose: thigh forward, lower leg angled down)
// =====================================================================

module leg(side=1) {
    // Built as if standing along +Z; the user rotates into seated pose
    // in the preview assembly.
    thigh_l = leg_h * 0.55;
    shin_l  = leg_h * 0.55;
    union() {
        // Thigh
        hull() {
            cylinder(d=leg_d + 4, h=0.1);
            translate([0,0,thigh_l]) cylinder(d=leg_d, h=0.1);
        }
        // Knee detail
        translate([0,0,thigh_l]) sphere(d=leg_d + 2);
        // Shin (angled forward 80deg for seated pose)
        translate([0,0,thigh_l])
            rotate([80, 0, 0])
                hull() {
                    cylinder(d=leg_d, h=0.1);
                    translate([0,0,shin_l]) cylinder(d=leg_d*0.9, h=0.1);
                    translate([6, 0, shin_l]) sphere(d=leg_d*1.1);  // foot
                }
    }
}

// =====================================================================
//  YOKE  (mounts on servo horn, pulls two tendons symmetrically)
// =====================================================================

module yoke() {
    horn_hole_d = 5.0;   // SG90 spline ≈ 4.8mm, fit_tight clearance
    arm_len = 14;
    difference() {
        union() {
            // Central hub
            cylinder(d=12, h=4);
            // Two arms outward
            for (s=[-1,1]) translate([s*arm_len/2, 0, 2])
                cube([arm_len, 5, 4], center=true);
            // Tendon anchor bosses at each tip
            for (s=[-1,1]) translate([s*arm_len, 0, 2])
                cylinder(d=5, h=4, center=true);
        }
        // Servo horn hole
        cylinder(d=horn_hole_d, h=10, center=true);
        // Tendon termination holes at each tip
        for (s=[-1,1]) translate([s*arm_len, 0, 0])
            cylinder(d=tendon_ch_d, h=10);
    }
}

// =====================================================================
//  STANDALONE SERVO BRACKET  (printed separately, glues into torso)
// =====================================================================

module servo_bracket() {
    plate_w = sg90_body_w + 12;
    plate_l = sg90_body_l + 10;
    plate_t = 3;
    difference() {
        union() {
            cube([plate_w, plate_l, plate_t], center=true);
            translate([0, 0, plate_t/2]) servo_cradle();
        }
        // Mounting screw holes for SG90 tabs
        for (s=[-1,1]) translate([0, s*(sg90_body_l/2 + sg90_tab_overhang/2), 0])
            cylinder(d=2.2, h=plate_t + 4, center=true);
    }
}

// =====================================================================
//  ASSEMBLY PREVIEW
// =====================================================================

module assembly_preview() {
    // Torso (whole)
    color("burlywood") torso_solid();
    // Head on top
    translate([0, 0, torso_h/2 + head_d/2 - 8])
        color("burlywood") head();
    // Eye-board + muzzle on face
    translate([0, head_d/2 + torso_h/2 - 8, torso_h/2 + head_d*0.04])
        rotate([90,0,0]) color("saddlebrown") eye_board();
    translate([0, head_d/2 + torso_h/2 - 9, torso_h/2 - head_d*0.18])
        rotate([90,0,0]) color("saddlebrown") muzzle();
    // Arms at rest (pointing down)
    for (s=[-1,1]) translate([s*(torso_w/2 - 3), 0, torso_h*0.32])
        rotate([180, 0, 0])
            color("burlywood") arm_with_channel(s);
    // Legs in seated pose
    for (s=[-1,1]) translate([s*(torso_w/3), 0, -torso_h/2 + 4])
        rotate([90, 0, 0])
            color("burlywood") leg(s);
    // Internal servo (transparent)
    %translate([0, 6, -torso_h/2 + sg90_body_h/2 + 4])
        cube([sg90_body_w, sg90_body_l, sg90_body_h], center=true);
}

// =====================================================================
//  PART SELECTOR
// =====================================================================

if      (part == "head")          head();
else if (part == "eye_board")     eye_board();
else if (part == "muzzle")        muzzle();
else if (part == "torso_front")   torso_front();
else if (part == "torso_back")    torso_back();
else if (part == "arm_left")      arm_with_channel(-1);
else if (part == "arm_right")     arm_with_channel(1);
else if (part == "leg_left")      leg(-1);
else if (part == "leg_right")     leg(1);
else if (part == "yoke")          yoke();
else if (part == "servo_bracket") servo_bracket();
else                              assembly_preview();
