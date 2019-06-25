#!/bin/sh
set -x 
set -e

mkdir -p generated/
openscad -o generated/assembled.stl -Ditem=0 rotator.scad 

openscad -o generated/01_rotor_gear.stl -Ditem=1 rotator.scad 
openscad -o generated/02_rotor_ring.stl -Ditem=2 rotator.scad 
openscad -o generated/03_rotor_base.stl -Ditem=3 rotator.scad 
openscad -o generated/04_rotor_plate.stl -Ditem=4 rotator.scad 
openscad -o generated/05_rotor_globe_attachement_bottom.stl -Ditem=5 rotator.scad 
openscad -o generated/06_rotor_globe_attachement_bottom_ring.stl -Ditem=6 rotator.scad 


