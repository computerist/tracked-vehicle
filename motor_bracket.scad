use <Hexnut.scad>

module motor_bracket(){
	spindle_height = 105.7;
	difference() {
		union() {
			difference() {
				union() {
					linear_extrude(height=30) polygon(points=[[-52,0],[-15,spindle_height],[15,spindle_height],[52,0],[40,0],[6,spindle_height-10],[-6,spindle_height-10],[-40,0]],paths=[[0,1,2,3,4,5,6,7]]);
					translate([0,spindle_height-5.5,0]) cylinder(r=17,h=30);
				}
				union() {
					translate([0,spindle_height-5.5,1]) cylinder(r=15.5,h=60);
					translate([0,spindle_height,0]) cylinder(r=5.25,h=2,center=true);
					translate([-12.5,spindle_height-5.5,0]) cylinder(r=1.75,h=2,center=true);
					translate([12.5,spindle_height-5.5,0]) cylinder(r=1.75,h=2,center=true);
				}
			}
			union() {
				translate([-52-(7/2),0,0]) cube([7,5,30]);			
				mirror([1,0,0]) translate([-52-(7/2),0,0]) cube([7,5,30]);
			}
		}
		union() {
			translate([-52,2,15]) rotate(270,[1,0,0]) hexnut(flats=5, depth=20);
			translate([-52,2,15]) rotate(270,[1,0,0]) cylinder(r=2.7/2, h=20, center=true);
		}
		mirror([1,0,0]) union() {
			translate([-52,2,15]) rotate(270,[1,0,0]) hexnut(flats=5, depth=20);
			translate([-52,2,15]) rotate(270,[1,0,0]) cylinder(r=2.7/2, h=20, center=true);
		}
	}
}

motor_bracket();