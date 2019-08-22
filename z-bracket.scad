include <config.scad>
include <screwholes.scad>
include <nopscadlib/core.scad>

// FIXME: add holes to secure this thing
// FIXME: describe the origin of this part ... and decide if it's right.  There isn't an obvious "right" place for this one
module z_bracket() {
 extrusion=40; // for testing the module on it's own
	z_bracket_screwsize = 3;
	leg_length = 10+extrusion*4;
	thickness = extrusion-5;
	//translate([0, 0, 0]) cube([extrusion, leg_length, thickness]);  //cube version
	//translate([-extrusion, 0, -extrusion]) cube([extrusion, thickness, leg_length]);  //cube version

	//FIXME: not sure how I screwed the origin while developing, I'll incorporate into calculations below
	color(printed_part_color()) translate ([0,0,0]) 
	difference() {
	union() {
	translate([extrusion/2,leg_length/2, thickness/2]) rounded_rectangle([extrusion, leg_length, thickness], 2);
    translate([-extrusion/2,thickness/2, leg_length/2-extrusion]) rotate ([0,90,90])  rounded_rectangle([leg_length, extrusion, thickness], 2);

	intersection() {
		rotate ([0,270,0]) translate([thickness,thickness,-extrusion])fillet(extrusion,   extrusion*2); 
		rotate ([90,0,0]) translate([0,thickness,-thickness-extrusion])fillet(extrusion,   thickness+extrusion); 
		
	}
			

	 intersection() {
	 rotate ([0,180,0]) translate([0,thickness,-thickness-extrusion])fillet(extrusion,   extrusion+thickness); 
	rotate ([0,270,0]) translate([thickness,thickness,0])fillet(extrusion,   extrusion); 
	 }

rotate ([90,0,0]) translate([0,(thickness),-(thickness)])fillet(extrusion,   thickness); 
rotate ([0,180,0]) translate([0,thickness,-thickness])fillet(extrusion,   thickness); 
translate([-extrusion/2, 0, 0]) cube([extrusion, thickness, extrusion]);  //cube version

}
	
			
			translate([extrusion/2, extrusion*2.5-z_bracket_screwsize, 0])  screwholes(row_distance=extrusion*2,numberofscrewholes=3,Mscrew=z_bracket_screwsize,screwhole_increase=0.5);
		rotate ([90,0,0]) translate([-extrusion/2, -extrusion/2, -extrusion*1.5])   screwholes(row_distance=extrusion*3,numberofscrewholes=4,Mscrew=z_bracket_screwsize,screwhole_increase=0.5);
		}
	}
	

//translate ([main_body_size_x,nubbin_size_y+rounding,0]) 

z_bracket();

