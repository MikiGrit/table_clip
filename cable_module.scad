include <Round-Anything/MinkowskiRound.scad>

include <config.scad>
use <utils.scad>
use <lock.scad>

hook_length = 20;
hook_width_min = 10;
hook_space = 6;
hook_height = 6;
hook_thickness = 5;
module_length = lock_length();


module cable_holder(length = default_length) {
    module_height = hook_thickness + hook_height + 2;

    module skelet() {
        hooks_count = floor(length / (hook_space/2 + hook_width_min));
        hook_width = hook_width_min + (length - hooks_count*hook_width_min - (hooks_count-1)*hook_space) / hooks_count;

        //hooks
        for (a = [0: hook_width + hook_space : length]) {
            translate([lock_wall_width, a, 0]) cube([hook_length, hook_width, hook_thickness]);
            translate([lock_wall_width + hook_length - hook_thickness, a, hook_thickness]) cube([hook_thickness, hook_width, hook_height]);
        }

        //lock wall
        cube([lock_wall_width + rounding, length, module_height]);
    }

    module final() {
        difference() {
            translate([-rounding, 0, 0]) minkowskiRound(rounding, rounding/2, enable=1, $fa=6) skelet();

            translate([-rounding, 0, 0]) cube([rounding, length, module_height]);
        }

        translate([0, length/2, 0]) key(height = module_height);

    }

    //translate([length, 0, 0]) rotate([0, 0, 90]) final();
    final();
}

cable_holder(module_length);
