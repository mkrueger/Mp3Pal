difference()
{
    cube([60, 15, 4]);

    for (i=[0:3]) 
    {
        translate([5 + i * 15, 7, 4])
                cylinder(2, d=i + 5.4, center = true, $fn=6);
    }

}