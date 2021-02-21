include <Round-Anything/MinkowskiRound.scad>

include <config.scad>
use <utils.scad>
use <lock.scad>

power_supply_size = [25, 145, 68];
cord_connector_height = 18;
cord_connector_width = 26;
power_cable_d = 5;
box_thickness = 3.4;


module box_module() {
    inner_box_size = [power_supply_size[0], power_supply_size[1], power_supply_size[2] - 35];
    outer_box_size = [inner_box_size[0] + 2*box_thickness, inner_box_size[1] + 2*box_thickness, inner_box_size[2] + inner_box_size[0]/2 + box_thickness];

    module shape_box() {
        translate([0, 0, inner_box_size[0]/2]) box_inner_size(inner_box_size, thickness=box_thickness);
        cube([outer_box_size[0], outer_box_size[1], inner_box_size[0]/2]);
    }

    module shape() {

        difference() {
            shape_box();

            // rounded floor
            translate([inner_box_size[0]/2 + box_thickness, box_thickness, inner_box_size[0]/2 + box_thickness]) rotate([-90, 0, 0]) linear_extrude(height=inner_box_size[1]) circle(d=inner_box_size[0]);

            // hole for power cable
            translate([(outer_box_size[0] - power_cable_d)/2, outer_box_size[1] - box_thickness - 2*power_cable_d, 0]) cube([power_cable_d, box_thickness + 2*power_cable_d, outer_box_size[2]]);

            // hole for power cord
            translate([outer_box_size[0]/2, 0, power_supply_size[2]/2 + box_thickness]) rotate([-90, 0, 0]) linear_extrude(height=box_thickness) scale([cord_connector_height/cord_connector_width, 1.0]) circle(d=cord_connector_width);
            translate([(outer_box_size[0] - cord_connector_height)/2, 0, power_supply_size[2]/2 + box_thickness]) cube([cord_connector_height, box_thickness, outer_box_size[2] - power_supply_size[2]/2]);
        }
    }

    module final() {
        minkowskiRound(rounding, rounding, enable=1, boundingEnvelope=2.2*outer_box_size, $fs=0.75) shape();

        translate([0, outer_box_size[1]/2, rounding]) key(height = outer_box_size[2] - 2*rounding);
    }

    final();
}

box_module();
