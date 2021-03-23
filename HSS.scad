include <NopSCADlib/lib.scad>
$fn = 64;
grid = 1.27;

diode_gauge_mm = 0.508;
wire_gauge_mm = 0.559;
hzExpComp = 1.15;

pin2 = [-2*grid, 4*grid, 1.4];
pin1 = [3*grid, 2*grid, 1.7];

stem = [0, 0, 3.85];
peg1 = [-4*grid, 0, 1.95];
peg2 = [4*grid, 0, 1.95];
base = [11*grid, 11*grid, 3.5];

diode_dia = diode_gauge_mm * 0.98;
wire_dia = wire_gauge_mm * 1.08;

difference(){
    difference(){
        union(){
            // Main Body
            translate([0, 0, 0]){
                cube([base.x, base.y, base.z], center = true);
            }
        }

        union(){

            // Switch Pins
            translate([pin2.x, pin2.y, 0]){
                cylinder(h=base.z*2, d=pin2[2], center = true);
            }

            translate([pin1.x, pin1.y, 0]){
                    cylinder(h=base.z*2, d=pin1[2], center = true);
            }

            // Main Stem Clamp
            translate([stem.x, stem.y, 0]){
                cylinder(h=base.z*2, d=stem[2], center = true);
            }

            translate([0, -5, 0]){
                cube([1, 10, base.z*2], center = true);
            }

            // PCB Mount Pegs
            translate([peg1.x, peg1.y, 0]){
                cylinder(h=base.z*2, d=peg1[2], center = true);
            }

            translate([peg2.x, peg2.y, 0]){
                cylinder(h=base.z*2, d=peg2[2], center = true);
            }

            // Side Slots for removal
            translate([7.75, 0, 0])
                rotate([0, 45, 0])
                    cube([2, 20, 2], center = true);

            translate([-7.75, 0, 0])
                rotate([0, 45, 0])
                    cube([2, 20, 2], center = true);

            translate([0, 7.75, 0])
                rotate([45, 0, 0])
                    cube([20, 2, 2], center = true);

            translate([0, -7.75, 0])
                rotate([45, 0, 0])
                    cube([20, 2, 2], center = true);

        }

    }

    // Parametrically Set
    union(){
        // Bottom Face Diode Pin Slot
        translate([pin2.x-2*grid, pin2.y - pin2[2]/8*2.5, -base.z/2]){
            cube([4*grid, diode_dia * hzExpComp, diode_dia*4], center = true);
        }

        // Top Face Diode Wire Channel
        translate([0, pin2.y + pin2[2]/8*2.5, base.z/2]){
            cube([1.5*base.x, diode_dia, diode_dia*5], center = true);
            cube([1.5*base.x, 2*diode_dia, diode_dia*1.5], center = true);
        }

        // Bottom Face Column Wire Slot
        translate([-2*grid, pin1.y+pin1[2]/8, -base.z/2]){
            cube([1.5*base.x, wire_dia * hzExpComp, wire_dia*4.5], center = true);
        }

        // Row Wire Channel
        translate([0, -4*grid, base.z/2]){
            cube([1.5*base.x, wire_dia, wire_dia*5.5], center = true);
        }
    }

    // Manually Set
    union(){
        // Diode Body + Other Leg
        diode_angle = -10;
        translate([-2*grid-0.28, 1*grid, base.z/2])
            rotate([0, 0, diode_angle])
                union(){
                    rotate([90, 0, 0])
                        cylinder(h=3.2, d=2, center = true);

                    cube([diode_dia, 6.5*grid, diode_dia*3], center = true);

                    translate([0, -6.5*grid/2, 0])
                        cylinder(h = 10, d = 2.5*diode_dia, center = true);
                }

        translate([pin2.x-2.5*grid, -2*grid-0.25, -base.z/2]){
            cube([3.5*grid, diode_dia * hzExpComp, diode_dia*4], center = true);
        }
    }
}