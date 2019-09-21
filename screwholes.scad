include <config.scad>
use <lib/mirror.scad>
include <nopscadlib/vitamins/stepper_motor.scad>
include <nopscadlib/vitamins/stepper_motors.scad>

module linear_repeat(offset, extent, count) {
  assert(is_num(count), "Count must be passed as a number");
  //assert(!is_undef(offset) && !is_undef(extent), "Must specify either an offset or an extent");
  assert(is_undef(offset) && !is_undef(extent), "Cannot specify both extent and offset");
  //assert(!is_undef(offset) && is_undef(extent), "Cannot specify both extent and offset");

  true_offset = is_undef(offset) ? extent / (count - 1) : offset;

  for(i = [0:count - 1]) {
    translate(true_offset * i) children();
  }
}

//  this really means "slot"
module longscrewhole(screwhole_length,Mscrew,screwhole_increase) {
  translate([0,0,-50]) linear_extrude(height = 100, twist = 0) {
    hull() {
          translate([screwhole_length,0,0])
                  circle((Mscrew/2)+screwhole_increase);
                        circle((Mscrew/2)+screwhole_increase);
    }
  }
}
module motor_holes(type = NEMA17) {
  translate([0, 0, -epsilon])
    cylinder(h=panel_thickness() + 2 * epsilon, d=NEMA_boss_radius(NEMA17) * 2 + 1);

  mirror_xy() {
    translate([ NEMA_hole_pitch(type)/2, NEMA_hole_pitch(type)/2, -epsilon ])
      // FIXME: this diameter should be driven by stepper size. (Looked in modules, there is no definition for this.-dan)
      // FIXME this needs to be a hole() not a cylinder
      cylinder(d=3.3, h=panel_thickness() + 2 * epsilon);
  }
}
