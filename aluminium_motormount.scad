// vim: set nospell:

include <config.scad>
include <nopscadlib/core.scad>
use <lib/holes.scad>
use <lib/layout.scad>
use <screwholes.scad>
include <nopscadlib/vitamins/stepper_motor.scad>
include <nopscadlib/vitamins/stepper_motors.scad>
use <demo.scad>

// FIXME: rather than parameterize on screwsize, we could parameterize on NEMA size of motor - that would set all of
// a screw size, main motor hole size, and screw pattern from one variable

  function NEMAadjust() = 0 ;
  function part_thickness() = 1/4 * inch;  // part_thickness  of aluminium part in mm
module raw_aluminium_motor_mount(screwsize,motoradjustspacing) {
  extrusion = extrusion_width($extrusion_type);

  part_corner_rounding = 3;
  type = NEMAtypeXY();

  extra = NEMAadjust()+4;
  mount_length = NEMA_width(type) + extrusion + panel_thickness();
  //NEMA_body_radius(NEMAtypeXY()) * 2 + panel_thickness() + extrusion_width()/2 + extra  ;
  mount_width  = NEMA_width(type) ;
  adjust_screw_addon_length = extrusion * 2;
  adjust_screw_addon_width  = extrusion_width() + panel_thickness()/2 ;

color(alum_part_color()) {
  difference () {
  //main block
  //FIXME: add rounded corner to the join


//translate ([extrusion,-mount_width/2,0])
  union() {
    // Main rectangle
    translate ([(extrusion + panel_thickness())/2,0,0])
      rounded_rectangle([mount_length,mount_width,part_thickness()], part_corner_rounding);
    // screw adjustment rectangle
    translate ([extrusion_width()+adjust_screw_addon_length/2,-mount_width/2+adjust_screw_addon_width/2,0])
      rounded_rectangle([adjust_screw_addon_length,adjust_screw_addon_width,part_thickness() ], part_corner_rounding);
  }

  // FIXME: we shouldn't have mounting holes over the corner cube
  translate ([-extrusion*0.5,-mount_width+extrusion*1.5, part_thickness()])
    linear_repeat(extent=[0, mount_width-extrusion*2, 0], count=3 ) {
      clearance_hole(nominal_d=screwsize, h=50);
    }


//  translate ([-NEMA_length(NEMAtypeXY())-NEMAadjust()/2,-24.5,0])
    //motorhole(0,0,0);  //motor holes
      long_motor_holes(NEMAtypeXY());


translate ([+(extrusion/2),-43.3+(screwsize/2),2])
    rotate ([0,0,90])
      longscrewhole(screwhole_length=8,Mscrew=screwsize,screwhole_increase=0.15); //extrusion adjust
  }
}
//-NEMAadjust()/2
//NEMA_body_radius(NEMAtypeXY())
//-mount_length/2
module long_motor_holes(type) {


//translate ([-extrusion_width() - panel_thickness() - NEMA_width(type)/2, 0, 0])
  hull() {
    translate([NEMAadjust()/2, 0,-epsilon])
    cylinder(h=part_thickness() + 2 * epsilon, d=NEMA_boss_radius(type) * 2 + 3);
translate([-NEMAadjust()/2, 0, -epsilon])
    cylinder(h=part_thickness() + 2 * epsilon, d=NEMA_boss_radius(type) * 2 + 3);
  }
translate([(-mount_length/2-NEMAadjust())/2, 0, 0])
  mirror_xy() {
    hull() {
      translate([NEMA_hole_pitch(type)/2+NEMAadjust()/2, NEMA_hole_pitch(type)/2, -epsilon-30 ])
      // FIXME this needs to be a hole() not a cylinder
      //cylinder(d=3.3, h=panel_thickness() + 2 * epsilon);
      cylinder(d=3.3, h=60);
      translate([NEMA_hole_pitch(type)/2-NEMAadjust()/2, NEMA_hole_pitch(type)/2, -epsilon-30 ])
      cylinder(d=3.3, h=60);
    }

  }
}


}
// wraps raw_aluminium_motor_mount() and rotates part to convenient orientation and placement for placing on model
module aluminium_motor_mount(screwsize=3, motoradjustspacing=6) {
  extrusion = extrusion_width($extrusion_type);
  //translate([mount_length/2-extra, -47+extrusion, 6/2])
    rotate([0,0,180])
      raw_aluminium_motor_mount(screwsize=screwsize, motoradjustspacing=motoradjustspacing);
}


module steel_2020_motor_mount() {
// https://ooznest.co.uk/product/nema17-motor-mounting-plate/
color(alum_part_color())
    translate([40, -2.5, 0]) rotate([90, 0, 270])
      import("purchased_parts/NEMA17mountingplate.stl", convexity=3);
}


demo() {
  mirror([0,1,0])
    translate ([0,-60,0]) aluminium_motor_mount(screwsize=3,motoradjustspacing=6) ; //mirrored version
  aluminium_motor_mount(screwsize=3,motoradjustspacing=6) ;
}
