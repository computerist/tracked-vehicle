use <Hexnut.scad>

module countersunk_trough(r1=2.15, r2=4, length=10, depth=3) {
	rotate(90,[1,0,0]) linear_extrude(height=length, center=true) polygon(points=[[-r1,-depth],[-r2,0],[r2,0],[r1,-depth]],paths=[[0,1,2,3]]);
	translate([0,-length/2,-depth])cylinder(r1=r1, r2=r2, h=depth);
	translate([0,length/2,-depth])cylinder(r1=r1, r2=r2, h=depth);
}

module trough(r=2.15, length=10, depth=8.5) {
	translate([0,-length/2,0])cylinder(r=r, h=depth);
	translate([0,length/2,0])cylinder(r=r, h=depth);
	translate([-r,-length/2,0]) cube([r*2,length,depth]);
}

module screw_trough(shaft=2.3, length=10, depth=12.5, cs_depth=2.5, cs_r1=2.3, cs_r2=4) {
	translate([0,0,depth+0.05]) countersunk_trough(r1=cs_r1, r2=cs_r2, length=length, depth=cs_depth);
	trough(r=shaft, length=length, depth=depth);
};

module body(height=5, width=11, length=35) {
	bracket_radius = 12;
	nut_depth = 7.5;
	nut_flats = 13.2;
	axle_radius = 4.2;
	difference() {
		union() {
			translate([-width/2,-15,0]) cube([width,length+bracket_radius*2,height]);
			translate([0,-15,0]) cylinder(r=(width/2),h=height);
			translate([0,bracket_radius+(length-15),bracket_radius]) rotate(90,[0,1,0]) cylinder(r=bracket_radius,h=width, center=true);
			translate([-width/2,length-15,0]) cube([width+nut_depth,bracket_radius*2,bracket_radius]);
		}
		union() {
			translate([0,-10,0]) screw_trough(depth=height);
			translate([0,10,0]) screw_trough(depth=height);
			translate([0,(length-15)+bracket_radius,bracket_radius]) rotate(90,[0,1,0]) cylinder(h=width+1, r=axle_radius, center=true);
			translate([(width/2)-1,(length-15)+bracket_radius,bracket_radius]) rotate(90,[0,1,0]) hexnut(flats=nut_flats, depth=nut_depth+2);
		}
	}
}

translate([6.5,0,0]) body(height=12, width=11, length=35);
mirror([1,0,0]) translate([6.5,0,0]) body(height=12, width=11, length=35);