Just a notebook.

* cable management channels for wiring?
* aluminum brackets are fucking dumb, printed was a cheap solution. Put in corner corner cubes
* remove hinges easily - they add a lot to the render
*  have the balls to say "this is the best way we know how to build one today, at least for $goals"
like, encourage experimenting but don't require it
* It's worth set some goals to prioritise what the "mainline" machine is trying to achieve, .  then when someone proposes a mod it either furthers the goals or it doesn't
* page regarding tab formatting prefs
*  start making issues on github ... in cheesecore repo for new stuff since the ones on railcore repo will never be acted on there
*  we should define the machine in terms of the outside dimensions of the cube, not the extrusion length.  We seem to have a lot of calculating the outside dimensions of the machine based on extrusion length ... but if we defined in terms of the outside of the cube, we'd only have to calculate extrusion size in the frame module
And if we define it based on the outside of the cube primarily, then we don't have a weird case if you want to build a larger cube with 4040 and not use corner cubes
* somehow segregate "docuemtnation" like that vs "files for manufacturing", if that makes sense
*  on the dxf export -  when we get to the point of a script that generates build artifacts like the actual dxf and stl for a given build .... do one part per file, not a single dxf with all the panels.
* printer-to-printer consistency.  It's not good that end stops and rails go "about yonder".  those parts should be adjusted, or alignment parts added (simple spacers for beyond each end of the rail to locate it are fine) so printers come out within a mm or two of one another, not way different
I'm talking full tolerance stack - where your nozzle hits the bed and 0,0 should be pretty damn close to mine
*  "simplification" - IMO we should just model for the gates idlers/pulleys and call it good now that those are readily available.  If a guy wants to run cheap ones and shim up to the gates dimensions that's fine, but I don't see that as our problem
* use a $draft to selectively knock quality down.
* topic of screws for the side panels - rather than defining that as "5 screws" we should probably define it in terms of "no more than x mm between screws" and let openscad figure out how many screws that requires
*  move the build guide to git as well so we can just make a fucking PR
*  splitting the PSU/mains away from the electronics
* MGN12C and MGN12H  in nopscadlib check
* functioning screw lib with counterbore
*  if we made everything parametric right, we could also grow the frame on a 4040 build so it fit "standard size doors"acceptably too.
which ... a 4040 frame will need a bigger cube anyway, there's too much intrusion into the cube to make z-brackets work at 1515 lengths to make yokes work
* we could flip the y-rail so the carriage runs in the other plane,  then you would be WAY less z-constrained by the carriage.  So you could probably get to where you could run the hotend straight up into the BMG, run whatever the latest hotness in for pancake stepper on the extruder, put a fan on it for good measure, and then push the belts back until it works, and I think you could make the belt arrangement take up less x-space if you made the "right side" 2 belt holders not-adjustable and just clamped the belts there
* flip Z tokes to gain X and lose Z?
