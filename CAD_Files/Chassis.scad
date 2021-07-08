$fn=100;

width      = 230.5;
height     = 139.5;
depth      = 95;
strength   = 6;
socketSize = 12;
socketSink = 17;

backplateHeight=78;
backplateWidth=97;

module mountingSocket()
{
    difference()
    {
        cube([socketSize, socketSize, depth - socketSink], center = true);
        translate([0, 0, (depth - socketSink - 8.1) / 2])
            cylinder(h=8.1,r=2.8, center = true);
    }
}

module m3_screwSink()
{
    translate([0, 0, -depth / 2 + 3.2])
        cylinder(h=5.7,r=2, center = true);
}

difference()
{
    // box
    minkowski() {
        cube([width + strength * 2, height + strength * 2, depth], center = true);
        sphere(3);
    }
    translate([0, 0, strength / 2])
        cube([width, height, depth], center = true);

    // backplate sink
    translate([(backplateWidth - socketSize) / 2, 0, 0]) {
        translate([socketSize, (-height + backplateHeight) / 2, strength - (depth ) / 2])
            cube([backplateWidth, backplateHeight, strength * 4], center = true);
        
        // right
        translate([backplateWidth / 2 + socketSize + 6, (-height + backplateHeight) / 2, 0])
            m3_screwSink();
        
        // left
        translate([-backplateWidth / 2 + socketSize - 6, (-height + backplateHeight) / 2, 0])
            m3_screwSink();
        
        // top
        translate([socketSize, -height / 2 + backplateHeight + 6, 0])
            m3_screwSink();
    }
    // top holes
    translate([0, height / 2 + strength / 2, 0]) {
        rotate(a=[90,0,0]) { 
            translate([-96/2, 0, 0])
                cylinder(h=strength * 2, r=2, center = true);
            translate([96/2, 0, 0])
                cylinder(h=strength * 2, r=2, center = true);
            translate([-35, 17, 0])
                cylinder(h=strength * 2, r=6, center = true);
            translate([-35 - 43, 14, 0])
                cylinder(h=strength * 2, r=4, center = true);
        }
    }
    
    // RFID screw SINK
    translate([0, height / 2, 0]) {
        rotate(a=[90,0,0]) { 
            translate([60, 0, 0])
                cylinder(h=4, r=1.6, center = true);
        }
    }
}


translate([0, 0, -socketSink / 2]) {
    translate([(width - socketSize) / 2, (-height + socketSize) / 2, 0])
        difference()
        {
            mountingSocket();
            translate([-3, 0, 19 + socketSink / 2 + strength + ( -depth ) / 2])
                cube([6, socketSize, 5], center = true);
        }

    difference()
    {
        translate([(width - socketSize) / 2, (height - socketSize) / 2, 0])
            mountingSocket(); 
        translate([(width - socketSize) / 2, (height - 4) / 2, -5])
            cube([socketSize, 4, depth - 25], center = true);
    }

    translate([(-width + socketSize) / 2, (-height + socketSize) / 2, 0])
        mountingSocket(); 
    translate([(-width + socketSize) / 2, (height - socketSize) / 2, 0])
        mountingSocket(); 

    translate([0, (height - socketSize) / 2, 0])
        mountingSocket(); 
    
    translate([0, (-height + socketSize) / 2, 0])
        difference()
        {
            mountingSocket();
            translate([3, 0, 19 + socketSink / 2 + strength + ( -depth ) / 2])
                cube([6, socketSize, 5], center = true);
        }
}