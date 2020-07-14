// Number and angle of cylinders
CONFIGURATION = 1; // [1:Man, 2:Woman]

// Distance between the stepper motor screws in millimeters
MOTOR_SIZE = 31; // [20:0.1:50]

// Diameter in millimeters inside the motor screw holes
MOUNTING_TAB_SIZE = 6.15; // [4.5:0.01:7.5]

// Tolerance between moving parts
TOLERANCE = 0.2; // [0.1:0.05:0.5]

$fn     = 24 + 0;                // Curve resolution
PIN     = 2 + 0;                 // Pin radius
WALL    = 2 + 0;                 // Wall thickness
MOUNT   = MOUNTING_TAB_SIZE / 2; // Motor mount tab radius
SQRT2   = sqrt(2);               // Square root of 2
TOLHALF = TOLERANCE / 2;         // Half of the part tolerance
CRANK   = MOTOR_SIZE / 6;        // Peddle crank length
ROD     = MOTOR_SIZE / 2;        // Connecting rod length
PIN_HEIGHT = 4 + 0;
OCTO_R  = sqrt( 4 - 2 * SQRT2 ); // Found in octo-math.md
TIRE    = 2*OCTO_R;              // Tire diameter




/***************************************
 *  Layout all the parts for printing  *
 ***************************************
 */


/***************************************************
 *  Modules for building each part of the bicycle  *
 ***************************************************
 */

module mount() {
	d = MOUNT/2;

	translate([0, 0, -1])
		difference() {
			cylinder(r = MOUNT, h = 1); // outside diameter
			translate([0, 0, -1])
				cylinder(r = MOUNT-0.6, h = 3); // inside diameter
		}
}

module pin() {
	// Pin body
	cylinder(r = PIN, h = PIN_HEIGHT);

	// Upper cone
	translate([0, 0, PIN_HEIGHT+0.5])
		cylinder(r1 = PIN + 0.5, r2 = PIN, h = 0.5);

	// Lower cone
	translate([0, 0, PIN_HEIGHT])
		cylinder(r1 = PIN, r2 = PIN + 0.5, h = 0.5);
}

module spoke(length) {
	translate([0, -0.5, -1])
		cube([length, 1, 2]);
}

module wheel(radius, spokes) {
	a = 360/spokes; // Angle for each spoke

	union() {
		rotate_extrude(angle=360, convexity=4, $fn=$fn*2)
			translate([radius, 0, 0])
				rotate(22.5, [0,0,1])
					circle(d=TIRE, $fn=8);

		for (i = [0:spokes-1])
			rotate([0, 0, i*a])
				spoke(radius);
	}
}

module frame() {
	R = MOTOR_SIZE/2; // Upper frame radius
	r = MOTOR_SIZE/4; // Lower frame radius
	union() {
		rotate_extrude(angle=135, convexity=4, $fn=$fn*2)
			translate([R, 0, 0])
				rotate(22.5, [0,0,1])
					circle(d=TIRE, $fn=8);

		translate([R, 0, 0])
			rotate(180, [0,0,1])
				translate([-r, 0, 0])
					rotate_extrude(angle=90, convexity=4, $fn=$fn*2)
						translate([r, 0, 0])
							rotate(22.5, [0,0,1])
								circle(d=TIRE, $fn=8);
	}
}
