// vim: set nospell:
include <nopscadlib/core.scad>
include <nopscadlib/lib.scad>
use <lib/mirror.scad>
use <extrusion.scad>
use <top_enclosure_side_panels.scad>
use <top_enclosure_frame.scad>
include <config.scad>
use <validation.scad>
use <door_hinge.scad>
use <demo.scad>
use <top_enclosure_parts.scad>

$fullrender=false;
//FIXME 45 is L height from topenclosure part

demo() {
  $front_window_size = front_window_zl;
  // FIXME : This needs to be derived from the actual frame size.
  $frame_size = [490, 455, 250];
  $rail_specs = rails_rc300zl;

  translate ([0, 0, -frame_size().z / 2 - 150])
    top_enclosure_all($extrusion_type = extrusion15);
  }

module top_enclosure() {
  translate ([0, 0, frame_size().z / 2 + enclosure_size().z/2 - extrusion_width() + 42]) {
    frame();
    %all_side_panels();
    hinges();
    handle();
  }
  printed_interface_arrangement();
}


module printed_interface_arrangement()

{
  adjust = 150;
  //MOTORS
translate ([frame_size().x/2 + extrusion_width()   , frame_size().y / 2 , frame_size().z / 2]) rotate ([0,0,90])
  pass_thru_motor(frame_size().x / 2 + extrusion_width() /2 ,frame_size().y / 2 ,60,40);

translate ([frame_size().x / 2  , -frame_size().y/2 - extrusion_width() , frame_size().z / 2])
  pass_thru_motor(frame_size().y / 2 + extrusion_width() /2 ,frame_size().x / 2 + extrusion_width(),40,60);


//IDLERS
translate ([-frame_size().x / 2  , frame_size().y/2 + extrusion_width() , frame_size().z / 2]) rotate ([0,0,180])
pass_thru_idler(frame_size().y / 2 +extrusion_width() /2  , frame_size().x / 2  ,35,90);

translate ([-frame_size().x/2 - extrusion_width() , -frame_size().y / 2  , frame_size().z / 2]) rotate ([0,0,-90])
  pass_thru_idler(frame_size().x / 2 - extrusion_width() /2, frame_size().y / 2  ,90,35);
}
