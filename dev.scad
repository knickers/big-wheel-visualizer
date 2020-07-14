include <high-wheel.scad>;

module combined(explode = 0) {
	a = $t * 360;           // angle of the crankshaft

	frame();

	rotate([0, 0, a]) {
		main_wheel();
	}
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
combined();
