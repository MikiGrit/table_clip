module quickMinkowski(rounding) {
    translate([rounding, rounding, rounding]) minkowski() {
        children();
        sphere(r=rounding);
    }
}

module box(a, thickness) {
    inner_box_width = a[0] - 2*thickness;
    inner_box_length = a[1] - 2*thickness;
    inner_box_height = a[2] - thickness;

    difference() {
        cube(a);

        translate([thickness, thickness, thickness]) cube([inner_box_width, inner_box_length, inner_box_height]);
    }
}
