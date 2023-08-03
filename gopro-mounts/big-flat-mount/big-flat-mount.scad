plateWidth = 60;
plateDepth = 60;
plateThickness = 4;
slotSize = 3;
holeSize = 5.5;
slotDepth = 20;

module makeMount() {
  makePlate();
  difference(){
    union(){
      translate([0, 0, 0]) rotate([0, 0, 90]) makeConnector(slotSize, holeSize, "3tab");
    }
  }
}

module makePlate() {
  cube(size = [plateWidth, plateDepth, plateThickness], center = true);
}

module makeConnector(type = "3tab"){

  width = slotSize * 5;
  
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
    
    makeNutHolder();
  }
}

module makeNutHolder(){
  
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


makeMount();
