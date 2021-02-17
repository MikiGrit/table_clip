//include <Round-Anything/MinkowskiRound.scad>

include <config.scad>
use <utils.scad>
use <lock.scad>

module_width = 20;
hook_width_min = 10;
hook_space = 6;
hook_height = 6;
module_length = lock_length();


module cable_holder(length = default_length) {
    module_width_true = module_width - rounding;
    module_height = plane_thickness + hook_height + 2;
    module_height_true = module_height - 2*rounding;
    length_true = length - 2*rounding;

    module skelet() {
        hook_height_true = hook_height - rounding;

        hooks_count = floor(length / (hook_space/2 + hook_width_min));
        hook_width = hook_width_min + (length - hooks_count*hook_width_min - (hooks_count-1)*hook_space) / hooks_count;
        hook_width_true = hook_width - 2*rounding;

        //hooks
        for (a = [0: hook_width + hook_space : length_true]) {
            translate([0, a, 0]) cube([module_width_true, hook_width_true, plane_thickness_true]);
            translate([0, a, plane_thickness_true]) cube([plane_thickness_true, hook_width_true, hook_height_true]);
        }

        //lock wall
        translate([module_width_true - lock_module_width_true, 0, 0]) cube([lock_module_width_true, length_true, module_height_true]);
    }

    module final() {
        difference() {
            quickMinkowski(rounding) skelet();
            // translate([rounding, rounding, rounding]) minkowskiRound(rounding/2, rounding/2, true, [2*module_width + 1, 2*length + 1, 2*module_height + 1], $fs=1) skelet();

            translate([module_width, 0, 0]) cube([rounding, length, module_height]);
        }

        translate([module_width, length/2, 0]) rotate([0, 0, 180]) key(height = module_height);

    }

    //translate([length, 0, 0]) rotate([0, 0, 90]) final();
    final();
}

cable_holder(module_length);
