$fn=100;

backplateHeight=58;
backplateWidth=85;

depth  = 6;
sinkHeight = 3.5;

difference()
{
    cube([backplateWidth, backplateHeight, 4], center = true);
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