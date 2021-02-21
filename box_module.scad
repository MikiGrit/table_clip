include <Round-Anything/MinkowskiRound.scad>

include <config.scad>
use <utils.scad>
use <lock.scad>

box_thickness = 4;
box_size = [60, 100, 30];


module box_module(box_size, box_thickness) {

    module shape() {
        minkowskiRound(rounding, rounding, enable=1, boundingEnvelope=2.2*box_size, $fs=1.0) {
            box(box_size, thickness=box_thickness);
        }
    }

    module final() {
        shape();

        translate([0, box_size[1]/2, rounding]) key(height = box_size[2]-2*rounding);
    }

    final();
}

box_module(box_size, box_thickness);
