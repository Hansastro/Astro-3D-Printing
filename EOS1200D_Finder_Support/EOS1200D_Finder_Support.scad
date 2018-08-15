$fn = 150;

basePlateLength = 78;
basePlateWidth = 42;
basePlateThick = 5.5;

verticalPlateHeight = 94;
verticalPlateThick = 7;

supportPlateLength = 39;
supportPlateWidth = 35;
supportPlateThick = 12;
supportPlateOffetX = 50;
supportPlateOffsetY = -20;

ScrewDistance = 20;

fingerHeight =89;
fingerLength = 8.5;
fingerThick = 3;
fingerTeeth = fingerThick + 3;

module photoScrewHole(length, height, bigDiameter, smallDiameter)
{
    union()
    {
        hull()
        {
            cylinder(h=height, d=smallDiameter);
            translate([length - (bigDiameter/2 + smallDiameter/ 2), 0, 0])
            cylinder(h=height, d=smallDiameter);
        }
    translate([0,0,0])
    cylinder(h=height, d=bigDiameter);
    }
}

module base()
{
    union()
    {
        // Base Plate
        difference()
        {
            union()
            {
                translate([-basePlateLength/2, -basePlateWidth/2, 0])
                cube([basePlateLength, basePlateWidth, basePlateThick]);
                
                translate([-42/2 + 15,-42/2,-4])
                cube([42,42,4]);
                
                // Blocking hole
                difference()
                {
                    translate([basePlateLength/2-20 - supportPlateThick+6,
                            -basePlateWidth/2 - 4,
                            0])
                    cube([20 + supportPlateThick, 4, basePlateThick + 4 + 20]);
                    
                    translate([basePlateLength/2-10,-10,10 + basePlateThick])
                    rotate([90,0,0])
                    cylinder(h=20, d=4.6);
                    
                    translate([-10,-basePlateWidth/2 - 6,26])
                    rotate([0,45,0])
                    cube([30, 10, 60]);
                }
            }
            // Hole for the photo screw
            translate([-basePlateLength/2 + 12, 0, -1])
            photoScrewHole(length=25, height=20, bigDiameter=8, smallDiameter=5.5);
            
            // hole for photo plate screw
            translate([15, 0, 0])
            union()
            {
                translate([0, 0, -20])
                cylinder(h=40, d=5.5);
                
                translate([0, 0, basePlateThick-5])
                cylinder(h=40, d=9.6, $fn=6);
            }
        
        }
        union()
        {
            difference()
            {
                translate([basePlateLength/2, -basePlateWidth/2, 0])
                cube([verticalPlateThick, basePlateWidth, verticalPlateHeight]);
                
                translate([basePlateLength/2 - 1, 0, 20 + basePlateThick])
                cube([verticalPlateThick + 2, 14, 40]);
            
                hull()
                {
                    translate([30, 7 + 1.5, basePlateThick + 30 - 10 + 20])
                    rotate([0,90,0])
                    cylinder(h=30, d=20);
                    
                    translate([30, 7, basePlateThick + 30 - 7])
                    rotate([0,90,0])
                    cylinder(h=30, d=15);
                }
            }
            // finger
            
            translate([basePlateLength/2 - 9, -8,fingerHeight - 8])
            union()
            {
                cube([fingerLength+1, 14,3]);
                translate([0,0,-fingerTeeth +3])
                cube([1.5, 14, fingerTeeth]);
            }
        }
    }
}

module support()
{
union()
    {
      translate([supportPlateOffetX + supportPlateWidth/2, supportPlateOffsetY - supportPlateLength/2, 0])
      difference()
        {
    
            
            //translate([ScrewDistance, 0, 0])
            //cylinder(h=supportPlateThick + 3, d=4);
            translate([-supportPlateWidth/2, -supportPlateLength/2, 0])
            cube([supportPlateWidth,supportPlateLength,supportPlateThick]);  
            
            // Screws
            translate([-ScrewDistance/2, 0, -1.5])
            cylinder(h=supportPlateThick + 3, d=4.5);
            translate([-ScrewDistance/2, 0, 2.5])
            cylinder(h=supportPlateThick + 3, d=8.5, $fn=6);
            
            translate([ScrewDistance/2, 0, -1.5])
            cylinder(h=supportPlateThick + 3, d=4.5);
            translate([ScrewDistance/2, 0, 2.5])
            cylinder(h=supportPlateThick + 3, d=8.5, $fn=6);
        
         }
     difference()
         {
         hull()
             {
             translate([supportPlateOffetX + supportPlateWidth/2, supportPlateOffsetY - supportPlateLength/2, 0])
             translate([-supportPlateWidth/2 + 0.1, -supportPlateLength / 2, supportPlateThick - 6])
             cube([2.1, supportPlateLength, 6]);
             
             translate([verticalPlateThick / 2 - 0.5,0,0])
             cube([verticalPlateThick, basePlateWidth, 15]);    
             }
         hull()
             {
                 translate([21,0,0])
                 cylinder(h=30, d=20);
                     
                 translate([38,-23,0])
                 cylinder(h=30, d=10);
             }
        }
     hull()
         {
             translate([supportPlateOffetX - 8, supportPlateOffsetY - supportPlateLength + 20, supportPlateThick - 6])
             cylinder(h=6, d=5);
             //cube([3,10,6]);
             translate([7,verticalPlateThick/2 - 5,-verticalPlateHeight + 15])
             cylinder(h=27, d=verticalPlateThick);
             //cube([verticalPlateThick,5,15]);
         }
    }
}

//photoScrewHole(20, 20, 10, 5);

difference()
{
    union()
    {
        base();
        translate([basePlateLength/2+ verticalPlateThick - 2 -8, -basePlateWidth/ 2, verticalPlateHeight - 15])
        support();
    }
    translate([basePlateLength/2 + 9,0,verticalPlateHeight+0.1])
    rotate([0,180,180])
    scale([0.06, 0.06, 0.01])
    //cube(10,10.5);
    surface(file = "logo_small.png", center = true, invert = false);
}