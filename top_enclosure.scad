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
use <nopscadlib/printed/handle.scad>

$fullrender=false;

module top_enclosure() {
  translate ([0, 0, frame_size().z / 2 + 150]) {
    frame();
    %all_side_panels();
    hinges();
    handle();
  }
}

module handle() {
  color(printed_part_color())
    translate ([0, -enclosure_size().y / 2 - 6, 0 ])
      rotate ([90,0,0])
        handle_assembly();
}


demo() {
  $front_window_size = front_window_zl;
  // FIXME : This needs to be derived from the actual frame size.
  $frame_size = [490, 455, 250];
  $rail_specs = rails_rc300zl;

  translate ([0, 0, -frame_size().z / 2 - 150])
    top_enclosure_all($extrusion_type = extrusion15);
  }
