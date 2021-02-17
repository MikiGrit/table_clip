use <threadlib/threadlib.scad>

include <config.scad>
use <base.scad>

rounding = 1;

module screw() {
    screw_head_height = 6;
    screw_head_height_true = screw_head_height - 2*rounding;
    outer_diameter = screw_size + 8;
    outer_diameter_true = outer_diameter - 2*rounding;

    module knurl() {
        knurl_count = 6;
        knurl_diameter = PI * outer_diameter / (2*knurl_count);
        knurl_step = 360 / knurl_count;

        for (a = [0 : knurl_step : 359]) {
            dx = (outer_diameter_true / 2) * sin(a + knurl_step / 3);
            dy = (outer_diameter_true / 2) * cos(a + knurl_step / 3);
            translate([dx, dy, 0]) cylinder(d = knurl_diameter, h = screw_head_height_true, $fn = 16);
        }
    }

    module screw_head() {
        difference() {
            cylinder(d = outer_diameter_true, h = screw_head_height_true);

            knurl();
        }
    }

    module final() {
        translate([0, 0, screw_head_height]) bolt(screw_type, turns=screw_length);

        translate([0, 0, rounding]) minkowski() {
            screw_head();
            sphere(r=rounding);
        }
    }

    final();
}

screw();
