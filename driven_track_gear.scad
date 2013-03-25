module hexnut(flats=10, depth=5){
	sliceangle = 360 / 6;
	pointradius = flats / (2 * cos(sliceangle/2));
	flatoffset = flats * tan(sliceangle/2) / 2;
	union(){
		for(angle=[0:sliceangle:360]) {
			rotate(angle,[0,0,1]) linear_extrude(height=depth) polygon(points=[[0,-1],[flatoffset,flats/2],[-flatoffset,flats/2]],paths=[[0,1,2]]);
		}
	}
}


module octagon(side=30, height=12){
 	width = side+(2*sqrt((side*side)/2));
	translate([0,0,height/2]) intersection(){
		cube([width, width, height],center=true);
		rotate(45,[0,0,1])cube([width, width, height],center=true);
	}
}

module gear(face=30, cutout=8, height=11) {
	width = face+(2*sqrt((face*face)/2));
	nutflats = 5;// nut, flat to flat
	nutheight = 4; // nut, base to top
	screwshaft =  3.5; // screw shaft diameter
	screwhead = 5; // screw head diameter
	screwlength = 30; // screw length
	motorshaft = 5.5;
	motorshaftlength = 10;
	motorflatdepth=1;
	cutout_r = cutout/2;
	vertex_r = sqrt(((face/2)*(face/2))+((width/2)*(width/2)));
	difference() {
		union() {
			difference(){
				union() {
					octagon(face,height);
					for(angle=[0:45:315]){
						rotate(angle,[0,0,1]) translate([0,width/2,0])toothcurve(edge=face, height=height, cutout=cutout);
					}
				}
				union() {
					for(angle=[0:45:315]) {
						rotate(angle,[0,0,1]) rotate(22.5,[0,0,1]) translate([vertex_r,0,0])cylinder(r=cutout_r,h=height);
					}
					difference(){
						octagon(face+25,height);
						octagon(face+2,height);
					}
				}
				union() {
					translate([0,0,1]) cylinder(r=motorshaft/2,h=motorshaftlength);
					translate([-nutflats/2,((motorshaft/2)+3),height/2]) cube([nutflats,nutheight,height/2]);
					translate([0,0,height/2]) rotate(270,[1,0,0]) cylinder(r=screwshaft/2,h=width);
					translate([0,screwlength,height/2]) rotate(270,[1,0,0]) cylinder(r=screwhead/2,h=width);
					translate([0,((motorshaft/2)+3),height/2]) rotate(270,[10,0,0]) rotate(90,[0,0,1]) hexnut(flats=nutflats,depth=nutheight);
				}
				difference() {
					translate([0,0,3])cylinder(r=(width/2)-((cutout/2)),h=height);
					translate([0,0,3])cylinder(r=(motorshaft/2)+3+nutheight+5,h=height);
				}
			}
		}	
	}
}

module surround(inner=30) {
	difference(){
		octagon(inner+4,1);
		octagon(inner+3,1);
	}
	for(rotation=[0:45:360]){
		rotate(rotation+14.5,[0,0,1]) translate([(inner/2)+(inner*0.4),-0.5,0]) cube([inner/2,1,0.3]);
		rotate(rotation-14.5,[0,0,1]) translate([(inner/2)+(inner*0.4),-0.5,0]) cube([inner/2,1,0.3]);
	}
}

gear();
surround();

module toothcurve(edge=30,height=5,cutout=8,wiggle=1) {
	intersection() {
		translate([edge/2,0,0])cylinder(r=edge-(cutout/2),h=height);
		translate([-edge/2,0,0])cylinder(r=edge-(cutout/2),h=height);
	}
}

//translate([5,0,0]) cube([34,1,4]);

