include <external/gears/gears.scad>

include <external/28BYJ-48-Stepper-Motor.scad>

$fn=200;
sb =0.01;//substract bigger
ro = $t * 360/4;

module rotor_gear(){
translate([0,0,2])
    union(){
        
        translate([0,0,-2]) 
        difference(){
            cylinder(h=2,d=16);
            translate([0,0,-sb]) cylinder(h=2 + 2 * sb,d=6);
        }
        spur_gear (modul=1, tooth_number=13, width=5, bohrung=5.5, pressure_angle=20, schraegungswinkel=0, optimized=true);
        //next version I will probably want less teeth
        //spur_gear (modul=2, tooth_number=6, width=5, bohrung=5.5, pressure_angle=20, schraegungswinkel=0, optimized=true);

    }
}


module rotor_ring(){
    difference(){
        union(){
            
              difference(){
                cylinder(h=10,d=52);
                translate([0,0,-sb]) cylinder(h=10 + 2 * sb,d=49);
            }

          ring_gear (modul=1, tooth_number=45, width=5, randbreite=2,       pressure_angle=20, schraegungswinkel=0);
	  //next version I will probably want less teeth
          //ring_gear (modul=2, tooth_number=21, width=5, randbreite=2, pressure_angle=20, schraegungswinkel=0);


        }
        translate([-30,-1.5,6 + sb]) cube([60,3,4]);     
    }
}




module plate(){
    there=53;
    myh=1.5;
    union() {
        difference(){
            cylinder(h=myh,d=there +3);
            union(){
                translate([0,0,-sb]) cylinder(h=myh  + 2 * sb ,d=12);
                translate([0,0,-sb]) translate([15,0,0])cylinder(h=myh + 2 * sb ,d=3);
                translate([0,0,-sb]) translate([-15,0,0])cylinder(h=myh + 2 * sb ,d=3);
                translate([0,0,-sb]) translate([0,15,0])cylinder(h=myh + 2 * sb ,d=3);
                translate([0,0,-sb]) translate([0,-15,0])cylinder(h=myh +2 * sb ,d=3);
            }
        }


        translate([0,0,myh]) 
        difference () {
             cylinder(h=myh +3,d=there +3);
             translate([0,0,-sb]) cylinder(h=50 ,d=there);
             
        }
        difference(){
            translate([-53/2,-1,0]) cube([53,2,4]);
            translate([-50/2 - sb,-1 - sb,-sb]) cube([50 + 2 * sb,22 + 2 * sb ,4 + 2 * sb ]);     
        }
    }
}

module globe_attachement_bottom(){
    w=3;
    d1 = 50.2;
    d2 = 52;
    d3 = 14 + 2* w;

    in_d1=10;
    in_d3=14;

    h1=1.2;
    h2=1.2;
    h3=12;



    difference() {
        union(){
            translate([0,0,h3 +h2])cylinder(d=d1,h=h1);
            translate([0,0,h3 +0]) cylinder(d=d2,h=h2);
            cylinder(d=d3,h=h3);
        }

        union() {
            translate([0,0,h3 + sb]) cylinder(d=in_d1 ,     h=h1 + h2 + 2 * sb );
            translate([0,0,-sb]) cylinder(d=in_d3 , h=h3 + sb * 2);
            
            translate([15,0 ,h3  - sb])cylinder(h=h1+h2 + 2* sb,d=3);
            translate([-15,0,h3  - sb])cylinder(h=h1+h2+ 2* sb ,d=3);
            translate([0,15 ,h3  - sb])cylinder(h=h1+h2 + 2* sb,d=3);
            translate([0,-15,h3  - sb])cylinder(h=h1+h2 + 2* sb,d=3);
        }
}
}
//r();



module globe_attachement_bottom_ring(){
    h=2;
    w=3;
    in_d3=14;
    d3 = in_d3 + 2* w;
    difference() {
                    cylinder(d=d3,h=h);
                    translate([0,0,-sb]) cylinder(d=in_d3,h=h  + 2 * sb);
    }
    
}

//plate();
//color("red") dus_d();


module demo(){
    # translate([0,-23,-22])  stepper28BYJ();
    translate([0,-15,7]) color("green") rotate([0,180,-15 +ro]) rotor_gear();
    rotate ([0,0,ro]) rotor_ring();
    # translate([0,-28,-3]) color("red") import("rotator_base.stl", convexity=6);
    translate([0,0,13]) rotate([0,180,0]) rotate([0,0,- ro]) plate();
    translate([0,0,28]) rotate([0,180,0]) rotate([0,0, -ro]) globe_attachement_bottom();
    translate([0,0,31]) rotate([0,180,0]) rotate([0,0, -ro]) globe_attachement_bottom_ring();
    //# sphere(d=300);
}
//demo();

module assembly_item(n) { children(n); } ;

assembly_item(item)
{
    demo();
    translate([0,0,0])     rotor_gear();
    translate([0,40,0])    rotor_ring();
    translate([50,70,0])   import("rotator_base.stl", convexity=6);
    translate([50,0,0])    plate();
    translate([0,-50,-15]) rotate([180,0,0]) globe_attachement_bottom();
    translate([-20,0,-2])  rotate([180,0,0]) globe_attachement_bottom_ring();
}

//children(1);
//plate();
//a();
//globe_attachement_bottom();
//r();

//r();
//plate();
//a();
//r();
