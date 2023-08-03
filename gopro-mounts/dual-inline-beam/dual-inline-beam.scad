// minimum 15 for positive connector angles, minimum 40 for negative connector angles
BeamWidth = 45;
// minimum 15 for positive connector angles, minimum 40 for negative connector angles
BeamWidth2 = 0;
// length of legs
LegLength = 50;
// degrees
Connector1Angle = 0;
// degrees
Connector2Angle = 120;
NutDiameter = 9.5;
NutType = "hexagonal"; //[hexagonal, pentagonal, square, none]

module makeMount(){
    $fn = 90;
    
    slotSize = 3;
    width=slotSize * 5;
    holeSize = 5.5;
    
    difference(){
        union(){
            makeBeam(slotSize, holeSize);
            translate([BeamWidth, 0, 0]) rotate([0, 0, Connector1Angle]) makeConnector(slotSize, holeSize, "3tab");
            translate([-BeamWidth2, 0, 0]) rotate([0, 0, -Connector2Angle + 180]) makeConnector(slotSize, holeSize, "3tab");
        }
        for(i = [0:2:5]){
            translate([80, 0, 0]) hull(){
                translate([0, 0, slotSize * i]) cylinder(h = slotSize, d = width + 1);
                translate([12 , -width / 2 - 0.5, slotSize * i]) cylinder(h = slotSize, d = 1);
                translate([-12, -width / 2 - 0.5, slotSize * i]) cylinder(h = slotSize, d = 1);
            }
        }
        translate([80, 0, 0]) cylinder(h = width, d = holeSize);
    }
}

module makeConnector(slotSize, holeSize, type = "3tab"){

    width = slotSize * 5;
    length = width + LegLength;
    // relative to origin
    slotDepth = 100;
    
    union(){
        difference(){
            hull(){
                //translate([-width + ((width / 4) + 1), -((width / 2)), 0]) cube([width, width / 2, width]);
                cylinder(h = width, d = width);
                translate([length + 1, 0, 0]) cylinder(h = width, d = width);
            }
            if(type == "3tab"){
                for(i = [1:2:3]){
                    translate([slotDepth / 2, -width / 2, slotSize * i]) cube([length + 1, width, slotSize]);
                }
            }  else if(type == "2tab"){
                for(i = [0:2:5]){
                    translate([slotDepth / 2, -width / 2, slotSize * i]) cube([length + 1, width, slotSize]);
                }
            }
            translate([length + 1, 0, 0]) cylinder(h = width, d = holeSize);
        }
        
        makeNutHolder(slotSize, holeSize);
    }
}

module makeNutHolder(slotSize, holeSize){
    
    width = slotSize * 5;
    length = width + LegLength;
    d1 = 14.5;
    d2 = 10.5;
    
    if(NutType == "hexagonal"){
        difference(){
            $fn = 6;
            translate([length + 1, 0, slotSize * 5]) cylinder(h = slotSize, d1 = d1, d2 = d2);
            translate([length + 1, 0, slotSize * 5]) cylinder(h = width, d = NutDiameter);
        }
    } else if(NutType == "pentagonal"){
        difference(){
            $fn = 5;
            translate([length + 1, 0, slotSize * 5]) cylinder(h = slotSize, d1 = d1, d2 = d2);
            translate([length + 1, 0, slotSize * 5]) cylinder(h = width, d = NutDiameter);
        }
    } else if(NutType == "square"){
        difference(){
            $fn = 4;
            translate([length + 1, 0, slotSize * 5]) cylinder(h = slotSize, d1 = d1, d2 = d2);
            translate([length + 1, 0, slotSize * 5]) cylinder(h = width, d = NutDiameter);
        }
    }
}

module makeBeam(slotSize, holeSize){
    width = slotSize * 5;

      hull(){
          translate([-BeamWidth2, 0, 0]) cylinder(h = width, d = width);
          translate([BeamWidth, 0, 0]) cylinder(h = width, d = width);
      }
}

makeMount(BeamWidth);
