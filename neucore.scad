// vim: set nospell:
include <nopscadlib/core.scad>
include <nopscadlib/lib.scad>
use <lib/layout.scad>
use <extrusion.scad>
use <side_panels.scad>
use <frame.scad>
include <config.scad>
use <foot.scad>
use <bed.scad>
use <z-tower.scad>
use <rail.scad>
use <electronics_box_panels.scad>
use <electronics_box_contents.scad>
use <validation.scad>
use <top_enclosure_parts.scad>
use <top_enclosure_side_panels.scad>
use <top_enclosure_frame.scad>
use <xy_motion.scad>
use <y_carriage.scad>

$fullrender=false;

//CORE MODULES
module enclosure() {
  frame();
  all_side_panels();
  hinges();
  %doors();
  feet(height=50);
 }

//FIXME: position isn't quite right
module kinematics(position) {
  xy_motion(position);
  z_towers(z_position = position[2]);
  bed(offset_bed_from_frame(position));
  x_rails(position.x);
  y_carriage(position);
}

//FIXME 45 is L height from topenclosure part
module top_enclosure() {
  translate ([0, 0, frame_size().z / 2 + enclosure_size().z/2 - extrusion_width() + 42]) {
    enclosure_frame();
     %enclosure_side_panels();
    enclosure_hinges();
    handle();
  }
  printed_interface_arrangement();
}

zlplus(position = [40, 110, 130]);
*customcore(position = [40, 110, 130]);
*translate([0, 800, 0]) rc300zl(position = [80, 90, 30]);
*translate([800, 0, 0]) rc300zlt(position = [150, 150, 130]);
*translate([0, 800, 0]) dancore(position = [150, 150, 130]);
*translate([800, 800, 0]) rc300zlv2(position = [80, 90, 30]);
*translate([800, 800, 0]) rc300zl40();
