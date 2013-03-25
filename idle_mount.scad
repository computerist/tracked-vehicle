use <Hexnut.scad>


module backing(shaft_radius=4.3, nut=[7.2,3.9], between=20) {
	difference() {
		union() {
			translate([-(nut[0]+4)/2,-between/2,0]) cube([nut[0]+4,between,nut[1]+2]);
			translate([0,between/2,0]) cylinder(r=(nut[0]+4)/2,h=nut[1]+2);
			translate([0,-between/2,0]) cylinder(r=(nut[0]+4)/2,h=nut[1]+2);
			
		}
		union () {
			translate([0,between/2,2]) hexnut(flats=nut[0], depth=nut[1]+0.1);
			translate([0,-between/2,2]) hexnut(flats=nut[0], depth=nut[1]+0.1);
			translate([0,between/2,0]) cylinder(r=shaft_radius/2,h=nut[1]+2);
			translate([0,-between/2,0]) cylinder(r=shaft_radius/2,h=nut[1]+2);
		}
	}
}

translate([6.5,0,0]) backing();
translate([-6.5,0,0]) backing();