module octagon(side=30, height=12){
 	width = side+(2*sqrt((side*side)/2));
	translate([0,0,height/2]) intersection(){
		cube([width, width, height],center=true);
		rotate(45,[0,0,1])cube([width, width, height],center=true);
	}
}

module gear(face=30, cutout=8, height=11) {
	width = face+(2*sqrt((face*face)/2));
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
					cylinder(r=8.5,h=height);
					for(angle=[0:45:315]) {
						rotate(angle,[0,0,1]) rotate(22.5,[0,0,1]) translate([vertex_r,0,0])cylinder(r=cutout_r,h=height);
					}
					difference(){
						octagon(face+25,height);
						octagon(face+2,height);
					}
					translate([0,0,1])cylinder(r=(width/2)-((cutout/2)),h=height);
				}
			}
			difference(){
				cylinder(r=24.5/2,h=8);
				cylinder(r=22.5/2,h=8);
			}
			for(nutangle=[0:90:360]) {
				rotate(nutangle,[0,0,1]) {
					translate([22.5/2,-2.5,0]) cube([(width/2)-((cutout/2))-(22.5/2),5,8]);
					translate([24.5/2+5,0,0]) cylinder(r=5,h=8);
				}
			}
		}	
		for(nutangle=[0:90:360]) {
				rotate(nutangle,[0,0,1]) translate([24.5/2+5,0,0]) {
					cylinder(r=3.25,h=3);
					cylinder(r=2,h=8.5);
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

module toothcurve(edge=30,height=5,cutout=8,wiggle=1) {
	intersection() {
		translate([edge/2,0,0])cylinder(r=edge-(cutout/2),h=height);
		translate([-edge/2,0,0])cylinder(r=edge-(cutout/2),h=height);
	}
}

module singlegear(){
	gear();
	surround();
}

//translate([0,40.5,0]) singlegear();
//translate([0,-40.5,0]) singlegear();

singlegear();

//translate([5,0,0]) cube([34,1,4]);

