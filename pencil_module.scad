include <Round-Anything/MinkowskiRound.scad>

include <config.scad>
use <utils.scad>
use <lock.scad>

pencil_size = [40, 40, 80];
paper_size = [30, 100, 60];
box_thickness = 3.4;


module pencil_holder(pencil_size, paper_size) {

    module shape() {
        minkowskiRound(rounding, rounding, enable=1, $fs=1) {
            translate([0, paper_size[1]-box_thickness, 0]) box(pencil_size, thickness=box_thickness);
            box(paper_size, thickness=box_thickness);
        }
    }

    module final() {
        shape();

        translate([0, (paper_size[1] + pencil_size[1])/2, 0]) key(height = paper_size[2]-rounding);
    }

    final();
}

pencil_holder(pencil_size, paper_size);
