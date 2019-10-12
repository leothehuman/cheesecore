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
use <standard_models.scad>
use <experimental_models.scad>

ver = version();
if(ver[0]<2019||(ver[0]==2019&&ver[1]<5)) {
    echo("<font color='red'>You need to update OpenSCAD.</font>");
    echo(str("<font color='red'>This OpenSCAD model was made with version 2019.5.0, you are using version ", str(version()[0]), ".",str(version()[1]), ".",str(version()[2]), "</font>"));
}

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
    enclosure_handle();
  }
  printed_interface_arrangement();
}

module printer(position = [0, 0, 0]) {
  validate();
  enclosure();
  kinematics(position);
  electronics_box_contents();
  translate ([0,0,-20]) electronics_box ();
  top_enclosure();
}

*tinycore(position = [40, 110, 130]);
*zlplus(position = [40, 110, 130]);
*customcore(position = [40, 110, 130]);
*translate([0, 800, 0]) rc300zl(position = [80, 90, 30]);
*translate([800, 0, 0]) rc300zlt(position = [150, 150, 130]);
*translate([0, 800, 0]) dancore(position = [150, 150, 130]);
*translate([800, 800, 0]) rc300zlv2(position = [80, 90, 30]);
*translate([800, 800, 0]) rc300zl40();

zlplus([0, 0, 0])
  printer();
