$fn=80;

headScrewDiameter = 8.75;
headScrewDeep = 3.5;

buttonThick = 7;

module cylinderLoop(amount, radius, diameter, height)
{
    for (angle = [0 : 360 / amount: 359])
    {
        rotate(a=[0, 0, angle])
        translate([radius, 0, 0])
        union()
        {
            cylinder(h=height - diameter, d=diameter, center=true);
            translate([0, 0 ,height/2 - diameter/2])
            sphere(d=diameter, center=true);
            translate([0, 0 ,-height/2 + diameter/2])
            sphere(d=diameter, center=true);
        }
    }
}

//cylinderLoop(5, 20, 20, 40);

module negativScrew(height, screwThick, screwWidth)
{
        union()
        {
            translate([-screwWidth / 2, -screwThick / 2, -1])
            cube([screwWidth, screwThick, ,height + 2]);
            rotate([0, 0, 90])
            translate([-screwWidth / 2, -screwThick / 2, -1])
            cube([screwWidth, screwThick, ,height + 2]);
        }
}  

difference()
{
    union()
    {
        difference()
        {
            cylinder(h=buttonThick, d=20);
            translate([0,0,buttonThick - headScrewDeep])
            cylinder(h=10, d=headScrewDiameter);

        }
        translate([0,0,3])
        //rotate([180,0,0])
        union()
        {
            translate([0,0,0])
            negativScrew(height= 2, screwThick= .8, screwWidth = 4);
            //cylinder(h=2.5, d=8.8);
        }
    }
   cylinderLoop(amount=10, radius=15, diameter=12, height=40);
   translate([0,0,0]) 
   cylinderLoop(amount=6, radius=6, diameter=3.3, height=23);
   translate([0,0,-1.5])
   sphere(d=7);
}