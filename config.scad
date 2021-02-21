$fa = 6;
$fs = 0.25;

// user defined parameters
default_length = 100;
plane_thickness = 5;
round_corners = true;
screw_length = 8;

//system parameters
tolerance = 0.2;
screw_size = 10;
lock_height = 24;
lock_depth = 2;
lock_width = 6.6;
lock_distance = 25;
lock_pieces = 3;
lock_wall_width = 4;
rounding = 1.5;

// computed parameters
lock_body_height = lock_height - lock_depth;
default_length_true = default_length - 2*rounding;
plane_thickness_true = plane_thickness - 2*rounding;
screw_type = str("M",screw_size);
lock_wall_width_true = lock_wall_width - rounding;
