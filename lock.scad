include <config.scad>
use <utils.scad>


module lock_piece(tolerance = 0, max_height = -1) {
    assert(max_height != 0 && max_height >= -1);

    width_big = lock_width/1.65*1.2;
    width_small = lock_width/1.65*0.75;
    width_max = lock_width;

    points = [
        [0, -(width_small + tolerance)/2, -lock_depth],
        [0,  (width_small + tolerance)/2, -lock_depth],
        [lock_depth + tolerance,  (width_big + tolerance)/2, 0],
        [lock_depth + tolerance, -(width_big + tolerance)/2, 0],
        [0, -(width_small + tolerance)/2, 4/5*lock_body_height],
        [0,  (width_small + tolerance)/2, 4/5*lock_body_height],
        [lock_depth + tolerance,  (width_big + tolerance)/2, 4/5*lock_body_height],
        [lock_depth + tolerance, -(width_big + tolerance)/2, 4/5*lock_body_height],
        [0, -(width_big + tolerance)/2, lock_body_height],
        [0,  (width_big + tolerance)/2, lock_body_height],
        [lock_depth + tolerance,  (width_max + tolerance)/2, lock_body_height],
        [lock_depth + tolerance, -(width_max + tolerance)/2, lock_body_height],
    ];
    faces = [
        [0,1,2,3],  // bottom
        [4,5,1,0],  // front
        //[7,6,5,4],  // top
        [5,6,2,1],  // right
        [6,7,3,2],  // back
        [7,4,0,3], // left
        [8,9,5,4], // top front
        [11,10,9,8], // top top
        [9,10,6,5], // top right
        [10,11,7,6], // top back
        [11,8,4,7], // top left
    ];

    if (max_height != -1 && max_height < lock_height) {
        translate([0, 0, max_height - lock_height]) difference() {
            translate([0, 0, lock_depth])  polyhedron(points, faces);

            translate([0, -(width_max + tolerance)/2, 0]) cube([lock_depth + tolerance, width_max + tolerance, lock_height + tolerance - max_height]);
        }
    } else if (max_height > lock_height) {
        translate([0, 0, max_height - lock_body_height]) polyhedron(points, faces);
    } else {
        translate([0, 0, lock_depth]) polyhedron(points, faces);
    }
}


module lock_module(height = -1, length = default_length) {
    height = (height == -1) ? lock_height : height;
    height_move = max(height - lock_body_height - lock_depth, 0);
    length_true = length - 2*rounding;

    module final() {
        difference() {
            quickMinkowski(rounding) cube([lock_module_width_true, length_true, height - 2*rounding]);

            translate([lock_module_width, 0, 0]) cube([rounding, length, height]);
        }

        translate([lock_module_width, length/2, height_move]) lock(max_height = height);
    }

    final();
}


function lock_length(pieces = lock_pieces, padding = 2/3*lock_distance) =
    (pieces-1) * lock_distance + 2*padding;


module key(pieces = lock_pieces, height = -1, padding = 2/3*lock_distance) {
    length = lock_length(pieces, padding);

    module part() {
        for (a = [-length/2 + padding : lock_distance : length/2 - padding]) {
            translate([0, a, 0]) lock_piece(max_height = height);
        }
    }

    rotate([0, 0, 180]) part();
}


module lock(pieces = lock_pieces, height = -1, padding = 2/3*lock_distance) {
    length = lock_length(pieces, padding);

    module part() {
        for (a = [-length/2 + padding : lock_distance : length/2 - padding]) {
            translate([0, a, 0]) lock_piece(tolerance = tolerance, max_height = height);
        }
    }

    part();
}
