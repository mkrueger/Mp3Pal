$fn=100;

width  = 230;
height = 139;
depth  = 4;

speakerScrewSpacing  = 82;
speakerX             = 68;
mountingHoleDistance = 6;

buttonDistance = 28;
buttonPadding  = 22;

module screw_hole()
{
    cylinder(depth, r=2, center=true);
}

module button_hole()
{
    cylinder(depth, r=12, center=true);
}

module led_button_hole()
{
    cylinder(depth, r=14, center=true);
}

difference()
{
    cube([width, height, 4], center = true);
    
    // mounting holes
    translate([width / 2 - mountingHoleDistance, -height / 2 + mountingHoleDistance, 0])
        screw_hole();
    translate([width / 2 - mountingHoleDistance,  height / 2 - mountingHoleDistance, 0])
        screw_hole();
    translate([-width / 2 + mountingHoleDistance, -height / 2 + mountingHoleDistance, 0])
        screw_hole();
    translate([-width / 2 + mountingHoleDistance,  height / 2 - mountingHoleDistance, 0])
        screw_hole();
    
    // Speaker
    translate([-width/2 + speakerX, 0, 0])
        cylinder(4, r=51,center=true);
    translate([-width/2 + speakerX + speakerScrewSpacing / 2, speakerScrewSpacing / 2, 0])
        screw_hole();
    translate([-width/2 + speakerX - speakerScrewSpacing / 2, speakerScrewSpacing / 2, 0])
        screw_hole();
    translate([-width/2 + speakerX + speakerScrewSpacing / 2, -speakerScrewSpacing / 2, 0])
        screw_hole();
    translate([-width/2 + speakerX - speakerScrewSpacing / 2, -speakerScrewSpacing / 2, 0])
        screw_hole();
        
    // Button grid
    buttonTopY = height / 2 - buttonPadding;
    buttonTopX = width / 2 - buttonPadding - 2;
    for (x=[0:2])
    for (y=[0:2])
        translate([buttonTopX - x * buttonDistance, buttonTopY - y * buttonDistance])
            button_hole();
    
    // LED buttons
    middleLedButtonX = buttonTopX - buttonDistance;
    translate([middleLedButtonX, buttonTopY - 2 * buttonDistance - 40, 0])
        led_button_hole();

    translate([middleLedButtonX - 33, buttonTopY + 8 - 2 * buttonDistance - 40, 0])
        led_button_hole();

    translate([middleLedButtonX + 33, buttonTopY + 8 - 2 * buttonDistance - 40, 0])
        led_button_hole();
}