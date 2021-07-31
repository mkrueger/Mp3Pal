include <arduino/arduino.scad>

$fn=40;
wallsize=4;

boxW=84+wallsize;
boxL=106+wallsize;
boxH=25;

minkowski()
{
    translate([-boxW/2,-boxL/2,0])
    {
       difference() {
           difference() {
              cube([boxW,boxL,boxH], center=false);
              translate([boxW-27,boxL-wallsize-1,7])
                cube([16,wallsize+6, boxH]);
              translate([boxW-55,boxL-wallsize-1,7])
                cube([12,wallsize+2, boxH]);
           }
            translate([wallsize,wallsize,wallsize])
                cube([boxW-wallsize*2,boxL-wallsize*2,boxH], center=false);
        }
    }
    sphere(1);
}

difference() {
    translate([0, 0, boxH])
        cube([boxW-wallsize,boxL-wallsize, wallsize*2], center=true);
    
    translate([0, 0, boxH+0.1])
        cube([boxW-wallsize*2,boxL-wallsize*2, wallsize*2+0.3], center=true);
}

translate ([boxW/2-wallsize,boxL/2-wallsize,0]) {
    rotate(a=[0,0,180]) {
        translate([2.54,15.24,wallsize])
            mount();
        translate([50.8,13.97,wallsize])
            mount();
        translate([2.54,90.17,wallsize])
            mount();
        translate([50.8,96.52,wallsize])
            mount();
        /*
        translate([0,0,wallsize+5])
            arduino(MEGA);*/
    }
}

translate ([4-boxW/2 + wallsize,62+-boxL+wallsize,0]) {
        translate([0,0,wallsize])
            mount();
        translate([18,0,wallsize])
            mount();
        translate([0,55,wallsize])
            mount();
        translate([18,55,wallsize])
            mount();
}
module mount() {
    difference() {
        cylinder(h=5,d=3.2 + 1.4 * 2);
        translate([0, 0, 1.1])
            cylinder(h=4.1, d=3.2);
    }
}