$fn=100;

backplateHeight=78;
backplateWidth=97;

depth  = 6;
ruthexM3SinkHeight = 5.7;
mountHeight = 20;

batteryHolderHeight = 58;

screwPadding = 12;

difference()
{
    cube([backplateWidth + screwPadding * 2, backplateHeight, mountHeight], center = true);
    h = 17;
    translate([0, 0, (mountHeight -h) / 2 ])
        cube([backplateWidth - screwPadding * 2, backplateHeight, h], center = true);

    
    // left box cut
    translate([backplateWidth / 2 + depth, 0, -depth / 2])
        cube([screwPadding + 8, backplateHeight, mountHeight], center = true);

    translate([backplateWidth / 2 + depth, (backplateWidth) / 2 - screwPadding - 3, -depth / 2])
        cube([screwPadding, screwPadding, 100], center = true);
    
    // right box cut
    translate([-backplateWidth / 2 - depth, 0, -depth / 2])
        cube([screwPadding + 8, backplateHeight, mountHeight], center = true);
    translate([-backplateWidth / 2 - depth, (backplateWidth) / 2 - screwPadding - 3, -depth / 2])
        cube([screwPadding , screwPadding, 100], center = true);


    // backplate mounting holes
    translate([-backplateWidth / 2 + screwPadding / 2, 0, (mountHeight - ruthexM3SinkHeight) / 2])
        cylinder(ruthexM3SinkHeight, r=2, center = true);
    translate([backplateWidth / 2 - screwPadding / 2, 0, (mountHeight - ruthexM3SinkHeight) / 2])
        cylinder(ruthexM3SinkHeight, r=2, center = true);

    // side mounting holes
    translate([-backplateWidth / 2 - screwPadding / 2 , 0, 0])
        cylinder(100, r=2, center = true);
    translate([backplateWidth / 2 + screwPadding / 2, 0, 0])
        cylinder(100, r=2, center = true);
    
    translate([0, -31, 0])
            cube([backplateWidth - 24, 16, 100], center = true);
    for (i=[0:3]) 
    {
        translate([3 * 15 / 2 + i * 15 - backplateWidth / 2, 
                   backplateHeight / 2 - batteryHolderHeight / 2, 0])
        cylinder(mountHeight, r=2, center = true);
    }
}

// usb port & sd card reader
difference()
{
    h = 5;
    color("Blue") 
        translate([0, -31 - screwPadding / 2, (mountHeight - h) / 2 ])
            cube([backplateWidth - 8, 16 + screwPadding, h], center = true);
    
    // usb hole
    translate([-15, -31, 0])
    {
        translate([-27 / 2, 0, 0]) 
        {
            cylinder(batteryHolderHeight, r=2, center = true);
            translate([0, 0, (mountHeight - 2) / 2]) 
                cylinder(2, r=4, center = true);
        }
        cube([12,8,batteryHolderHeight], center = true);
        translate([27 / 2, 0, 0]) 
        {
            cylinder(batteryHolderHeight, r=2, center = true);
            translate([0, 0, (mountHeight - 2) / 2]) 
                cylinder(2, r=4, center = true);
        }
    }
    
    translate([24, -25 - screwPadding / 2, mountHeight / 2  - 1.5])
      cube([25, 9,batteryHolderHeight], center = true);
    
    translate([0, -31 - screwPadding, mountHeight / 2 - 1.5])
        cylinder(batteryHolderHeight, r=2, center = true);
}

// battery top closing plate
difference()
{
    translate([0, -18 - screwPadding / 2, 0]) {
        cube([backplateWidth - screwPadding * 2, 2, mountHeight], center = true);
        translate([24, -2, 0])
            cube([25, 2, mountHeight], center = true);
    }
    translate([0, -18 - screwPadding / 2, 0])
        cube([8, 4, 6], center = true);
}
translate([11, -26 - screwPadding / 2, 0]) {
    cube([2, 14, mountHeight], center = true);
}

// pcb mount
pcbMountHeight = 2;
pcbMountYMod = 3;
translate([0, pcbMountYMod, (-mountHeight - pcbMountHeight) / 2])
difference()
{
    translate([0, 2, 0])
        cube([backplateWidth + 8, backplateHeight - 10, pcbMountHeight], center = true);
    translate([0, -(backplateHeight - 12) / 2 - 2, 0])
        cube([73, 14, 3], center = true);
    for (i=[0:3]) 
    {
        translate([3 * 15 / 2 + i * 15 - backplateWidth / 2, 
                   backplateHeight / 2 - batteryHolderHeight / 2 - pcbMountYMod, 0])
        cylinder(mountHeight, d=6.8, center = true, $fn=6);
    }
    translate([93/2, 54 / 2 + 3, 0]) 
    {
        cylinder(mountHeight, r=1.3, center = true);
        translate([0, -54, 0]) 
            cylinder(mountHeight, r=1.3, center = true);
        translate([-93, 0, 0]) 
        {
            cylinder(mountHeight, r=1.3, center = true);
            translate([0, -54, 0]) 
                cylinder(mountHeight, r=1.3, center = true);
        }
    }

}