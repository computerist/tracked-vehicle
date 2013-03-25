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

module idlercover(face=30, cutout=8, height=2){
	width = face+(2*sqrt((face*face)/2));
	difference() {
		union() {
			cylinder(r=(width/2)-((cutout/2))-0.5,h=height);	
			for(nutangle=[0:90:360]) {
				rotate(nutangle,[0,0,1]) translate([24.5/2+5,0,0]) {
					cylinder(r=6,h=8);
				}
			}
		}	
		cylinder(r=8.5,h=height);
		for(nutangle=[0:90:360]) {
			rotate(nutangle,[0,0,1]) translate([24.5/2+5,0,0]) {
				translate([0,0,4.5]) hexnut(flats=6.5,h=3.5);
				cylinder(r=2,h=8.5);
			}
		}
	}
}


idlercover(face=30);