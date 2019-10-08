// vim: set nospell:
include <nopscadlib/core.scad>
include <nopscadlib/lib.scad>
use <lib/layout.scad>
use <belts_pulleys.scad>
use <nopscadlib/vitamins/pulleys.scad>
use <aluminium_motormount.scad>
use <aluminium_idlermount.scad>
include <config.scad>
use <demo.scad>

module xy_motion(position = [0, 0, 0]) {
  // FIXME: this is not a final height for belts
  translate ([0, 0, frame_size().z / 2 + 10])
    corexy_belts([position.x-210, position.y]);
  // IDLER MOUNTS
  translate ([-frame_size().x / 2 + extrusion_width(), 0, frame_size().z / 2]) {
    mirror_y() {
      translate([0, -frame_size().y / 2 + extrusion_width(), 0])
        aluminium_idler_mount();
    }
  }
// MOTORS AND MOTOR MOUNTS
translate([frame_size().x / 2 - extrusion_width(), 0, frame_size().z / 2]){
  mirror_y() {
    translate([panel_thickness() + extrusion_width() + NEMA_width(NEMAtypeXY())/2,motor_pulley_link() + extrusion_width()/2 - 4  , 0])  // FIXME: what is the 4 for? Why does this work?
      #aluminium_motor_mount();
      //steel_2020_motor_mount();
    translate([panel_thickness() + extrusion_width() + NEMA_width(NEMAtypeXY())/2, motor_pulley_link() + 11 , 0])
      rotate([0, 0, 180]) NEMA(NEMAtypeXY());
    }
  }
}

demo(){
  xy_motion(position = [0, 0, 0]);
}
