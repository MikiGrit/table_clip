include <Round-Anything/MinkowskiRound.scad>

include <config.scad>
use <utils.scad>
use <lock.scad>

module_width = 30;
module_length = 100;
module_height = 60;
box_thickness = 4;


module pencil_holder(length) {

    module pencil_box() {
        inner_box_length = module_length - 2*box_thickness;
        inner_box_width = module_width - 2*box_thickness;
        inner_box_height = module_height - box_thickness;

        difference() {
            minkowskiRound(rounding, rounding, true, $fs=1) difference() {
                cube([module_width+rounding, module_length, module_height]);

                translate([box_thickness, box_thickness, box_thickness]) cube([inner_box_width, inner_box_length, inner_box_height]);
            }

            #translate([module_width, 0, 0]) cube([rounding+0.1, module_length, module_height]);
        }
    }

    module final() {
        pencil_box();

        translate([module_width, length/2, 0]) rotate([0, 0, 180]) key(height = module_height);
    }

    //translate([length, 0, 0]) rotate([0, 0, 90]) final();
    final();
}

pencil_holder(module_length);
