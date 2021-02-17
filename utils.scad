module quickMinkowski(rounding) {
    translate([rounding, rounding, rounding]) minkowski() {
        children();
        sphere(r=rounding);
    }
}
