
$fn = 300;

internDiameter = 30.3;
wallThickness = 6.0;

tubeHigh = 30;
ceilingThickness = 1.5;
viewHoleDiameter = 14;

focusHoleHeight = 10;


translate([0,1.3,tubeHigh])
rotate(a=180, v=[0,0,1])
canonAdpter();

difference()
{
    difference()
    {
        difference()
        {
            union()
            {
                difference()
                {
                    cylinder(h=tubeHigh,d=internDiameter + wallThickness*2);
                    translate([0,0,-ceilingThickness])
                    union()
                    {
                        translate([0 ,0, tubeHigh - 1])
                        cylinder(h=tubeHigh/2, d=viewHoleDiameter);
                    
                        cylinder(h=tubeHigh, d=internDiameter);
                    }
                }
                translate([-5, -internDiameter/2 - wallThickness - 2, 0])
                cube(size=[10, wallThickness, tubeHigh]);
           }
           translate([0,internDiameter/2 + 4,tubeHigh - ceilingThickness - focusHoleHeight/2])
           cube(size=[internDiameter + wallThickness*2, 25, focusHoleHeight], center=true);
        }
        rotate(a=90, v=[1,0,0])
        translate([0,tubeHigh / 1/3+2],0)
        cylinder(h=25, d=4.6);
    }
    union()
    {
        translate([0,0,-2])
        cylinder(h=internDiameter, d1=internDiameter+wallThickness, d2=2);
        translate([0,0,tubeHigh-8])
        cylinder(h=viewHoleDiameter, d1=2, d2=viewHoleDiameter*2);
    }
}

module canonAdpter()
{
    width = 35;
    length = 18;
    height = 3.2;
    supportThickness = 1.8 ; //1.72 a little too small
    supportWidth = 2.6;
    supportDistance = 21;
    
    translate([0, 0, height/2])
    difference()
    {
    cube(size=[width, length, height], center=true);
    union()
        {
            translate([0,+1,-0.1])
            cube(size=[supportDistance, length+0.3, height+ 0.3], center=true);
            translate([0, +1, -supportThickness])
            cube(size=[supportDistance + supportWidth*2, length+0.3, height], center=true);
        }
    }
}