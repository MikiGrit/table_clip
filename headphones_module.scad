use <chamfercyl.scad>

include <config.scad>
use <utils.scad>
use <lock.scad>

module_width = 50;
module_length = 100;
module_height = 12;
lock_width = 4;


module headphones_holder(length) {
    head_module_width = 20;
    head_module_length = module_width;
    head_module_thickness = 8;
    cable_module_width = 16;
    cable_module_length = 20;
    cable_module_thickness = 10;

    //radius from circular segment: https://en.wikipedia.org/wiki/Circular_segment
    //r = c**2 / (8*h) + h/2;

    module skelet_head() {
      head_r = (head_module_width*head_module_width) / (8*cable_module_thickness) + cable_module_thickness/2;
      head_wide = 2;
      head_end_length = 10;
      head_end_height = 20;
      head_end_length_true = head_end_length - 2*2*head_wide;
      head_end_height_true = head_end_height - 2*head_wide;

      difference() {
        union() {
          translate([0, 0, -head_r+head_module_thickness]) rotate([0, 90, 0]) chamfercyl(r=head_r, h=head_module_length, t=head_wide, b=-2*head_wide);

          translate([0, -head_r, -2*head_wide]) quickMinkowski(2*head_wide) cube([head_end_length_true, 2*(head_r - 2*head_wide), head_end_height_true]);
          translate([0, 0, head_end_height_true-head_r+head_module_thickness]) rotate([0, 90, 0]) chamfercyl(r=head_r, h=head_end_length, t=-2*head_wide, b=-2*head_wide);
        }

        translate([-0.5, -(head_r + head_wide), -2*(head_r+head_wide)]) cube([head_module_length+1, 2*(head_r + head_wide), 2*(head_r + head_wide)]);
      }

    }

    module skelet_cable() {
      hole_r = 1.2;
      hole_wide = 2;
      cable_module_length_true = cable_module_length + hole_r;
      hole_depth = 4/7*cable_module_length_true;

      translate([0, -cable_module_width/2, 0]) difference() {
        translate([0, cable_module_thickness/2, 0]) rotate([0,90, 0]) chamfercyl(r=cable_module_thickness/2, h=cable_module_length, t=2, b=-2, offset=[[0, cable_module_width-cable_module_thickness], [0, 0]]);

        // holder hole
        translate([hole_depth, cable_module_width/2, -cable_module_thickness/2]) chamfercyl(r=2*hole_r, h=cable_module_thickness, t=2*hole_wide);
        // hole line
        translate([hole_depth, cable_module_width/2, -cable_module_thickness/2]) chamfercyl(r=hole_r, h=cable_module_thickness, t=hole_wide, b=hole_wide, offset=[[-hole_depth, 0], [0, 0]]);
        // bottom cut
        translate([-0.5, -hole_wide, -cable_module_thickness]) cube([cable_module_length+1, cable_module_width+2*hole_wide, cable_module_thickness]);
      }
    }

    module lock_wall() {
      lock_width_true = lock_width - rounding;
      module_height_true = module_height - rounding;
      length_true = length - 2*rounding;

      translate([lock_width_true, 0, -rounding]) difference() {
        translate([-lock_width_true, 0, 0]) quickMinkowski(rounding) cube([lock_width_true, length_true, module_height_true]);

        translate([rounding, 0, rounding]) cube([rounding, length, module_height]);
        translate([-lock_width_true, 0, 0]) cube([lock_width + rounding, length, rounding]);
      }

      translate([lock_width, length/2, 0]) rotate([0, 0, 180]) key(height = module_height);
    }

    module final() {
        translate([0, 4/5*head_module_width, 0]) skelet_head();

        translate([module_width - cable_module_length, length - 4/5*cable_module_width, 0]) skelet_cable();

        translate([module_width, 0, 0]) lock_wall();
    }

    //translate([length, 0, 0]) rotate([0, 0, 90]) final();
    final();
}

headphones_holder(module_length);
