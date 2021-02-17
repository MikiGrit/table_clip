$fs = 0.6;

// user defined parameters
default_length = 100;
plane_thickness = 5;
side_thickness = 4;
table_depth = 20;
table_thickness = 20;
round_corners = true;
screw_size = 10;

//system parameters
tolerance = 0.2;
lock_height = 24;
lock_depth = 2;
lock_width = 6.6;
lock_distance = 25;
lock_pieces = 3;
lock_module_width = 2;
rounding = 1.5;

// computed parameters
lock_body_height = lock_height - lock_depth;
default_length_true = default_length - 2*rounding;
plane_thickness_true = plane_thickness - 2*rounding;
side_thickness_true = side_thickness - rounding;
table_depth_true = table_depth;
handle_depth = table_depth + plane_thickness;
handle_height = 2*plane_thickness + table_thickness + 2*rounding;
screw_type = str("M",screw_size);
lock_module_width_true = lock_module_width - rounding;
