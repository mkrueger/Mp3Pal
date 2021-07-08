$fn=100;

spacing = 1;
backplateHeight=78;
backplateWidth=97;

depth  = 6;
sinkHeight = 3.5;

difference()
{
    cube([backplateWidth - spacing, backplateHeight - spacing , 4], center = true);
    translate([-backplateWidth / 2 + 6, 0, 0])
        cylinder(depth, r=2, center = true);
    translate([backplateWidth / 2 - 6, 0, 0])
        cylinder(depth, r=2, center = true);
   
    translate([0, 0, depth - sinkHeight])
    {
        translate([-backplateWidth / 2 + 6, 0, 0])
            cylinder(sinkHeight, r=4, center = true);
        translate([backplateWidth / 2 - 6, 0, 0])
            cylinder(sinkHeight, r=4, center = true);
    }

}