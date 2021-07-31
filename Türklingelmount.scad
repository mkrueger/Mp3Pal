$fn=100;

backplateHeight=184;
backplateWidth=105;

depth  = 2;

difference()
{
    cube([backplateWidth, backplateHeight, depth], center = true);
    translate([-55 / 2, -142 / 2, 0])
        cylinder(depth, r=2, center = true);
    translate([55 / 2, -142 / 2, 0])
        cylinder(depth, r=2, center = true);
    translate([-55 / 2, 142 / 2, 0])
        cylinder(depth, r=2, center = true);
    translate([55 / 2,  142 / 2, 0])
        cylinder(depth, r=2, center = true);
    
   translate([0, -68 / 2, 0])
        cylinder(depth, r=2, center = true);
   translate([0, 68 / 2, 0])
        cylinder(depth, r=2, center = true);
   
    cube([25, 30, depth], center = true);

}