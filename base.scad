use <threadlib/threadlib.scad>

include <config.scad>
use <utils.scad>
use <lock.scad>

table_depth = 20;
table_thickness = 20;
side_thickness = 4;


module handle(lock_pieces = lock_pieces, length = -1) {
    assert(lock_pieces > 0);

    length = length == -1 ? lock_length(pieces=lock_pieces) : length;
    length_true = length - 2*rounding;
    table_depth_true = table_depth;
    side_thickness_true = side_thickness - rounding;

    module skelet() {
        // bottom part
        if (round_corners) {
            translate([side_thickness_true, table_depth_true, 0]) cube([table_depth_true, length_true - 2*table_depth_true, plane_thickness_true]);
            translate([side_thickness_true, length_true - table_depth_true, 0])
              linear_extrude(height=plane_thickness_true)
                intersection() {square(2*(table_depth_true)); circle(r=table_depth_true);}

            translate([side_thickness_true, table_depth_true, 0])
              linear_extrude(height=plane_thickness_true)
               intersection() {translate([0, -2*(table_depth_true), 0]) square(2*(table_depth_true)); circle(r=table_depth_true);}
        } else {
            translate([side_thickness_true, 0, 0]) cube([table_depth_true, length_true, plane_thickness_true]);
        }

        // connecting part
        cube([side_thickness_true, length_true, table_thickness + 2*plane_thickness_true + 2*rounding]);

        // top part
        if (round_corners) {
            translate([side_thickness_true, table_depth_true, plane_thickness_true + table_thickness + 2*rounding]) cube([table_depth_true, length_true - 2*table_depth_true, plane_thickness_true]);
            translate([side_thickness_true, length_true - table_depth_true, plane_thickness_true + table_thickness + 2*rounding])
              linear_extrude(height=plane_thickness_true)
                intersection() {square(2*(table_depth_true)); circle(r=table_depth_true);}

            translate([side_thickness_true, table_depth_true, plane_thickness_true + table_thickness + 2*rounding])
              linear_extrude(height=plane_thickness_true)
               intersection() {translate([0, -2*(table_depth_true), 0]) square(2*(table_depth_true)); circle(r=table_depth_true);}
        } else {
            translate([side_thickness_true, 0, plane_thickness_true + table_thickness + 2*rounding]) cube([table_depth_true, length_true, plane_thickness_true]);
        }
    }

    module screw_taps() {
        if (lock_pieces < 3) {
            translate([0, 0, -1.0]) tap(screw_type, turns=plane_thickness);
        } else {
            tap_distance = lock_distance * ((lock_pieces-1)/2) - 1/5*lock_distance;

            translate([0, tap_distance, -1.0]) tap(screw_type, turns=plane_thickness);
            translate([0, -tap_distance, -1.0]) tap(screw_type, turns=plane_thickness);
        }
    }

    module final() {
        handle_height = 2*plane_thickness + table_thickness + 2*rounding;

        difference() {
            translate([-rounding, 0, 0]) quickMinkowski(rounding) skelet();

            translate([-rounding, 0, 0]) cube([rounding, length, handle_height]);
            #translate([2/3*table_depth, length/2, 0]) screw_taps();
            #translate([0, length/2, 0]) lock(pieces = lock_pieces, height = 2*plane_thickness + table_thickness);
        }
    }

    translate([length, table_thickness + 2*plane_thickness, 0]) rotate([0, -90, 90]) final();
    //final();
}

handle(lock_pieces = 3, length=default_length);
