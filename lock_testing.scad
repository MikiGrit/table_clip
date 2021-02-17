include <config.scad>
use <lock.scad>


module test_key() {
    key();

    //#translate([0, -lock_width2/2, 0]) cube([lock_depth, lock_width2, lock_height]);
}

module test_lockhole_old() {
    difference() {
        cube([2*lock_depth, 2/3*default_length, lock_height]);

        translate([0, 1/3*default_length, 0]) lock(lock_groove = true, max_height = -1);
    }
}

module test_lockhole() {
    difference() {
        cube([2*lock_depth, lock_length(), 30]);

        translate([0, lock_length()/2, 0]) lock(height = 30);
    }
}

test_key();
// test_lockhole();
