include <high-wheel.scad>;

module combined(explode = 0) {
	wheel();
}

module exploded(explode) {
	translate([0, 0, MOTOR_SIZE])
		rotate([90, 0, 0])
			translate([0, 0, -explode*3])
				combined(explode);
}

/*
crank();
rod();

exploded(5);

rotate([90, 0, 0])
	combined();
*/
wheel(MOTOR_SIZE/2-4, 10);
frame();
