// source: https://reprap.org/forum/read.php?313,859885,859885

// chamfercyl - create a cylinder with round chamfered ends
module chamfercyl(
   r,              // cylinder radius
   h,              // cylinder height
   b=0,            // bottom chamfer radius (=0 none, >0 outside, <0 inside)
   t=0,            // top chamfer radius (=0 none, >0 outside, <0 inside)
   offset=[[0,0]], // optional offsets in X and Y to create
                   // convex hulls at slice level
   slices=10,      // number of slices used for chamfering
   eps=0.01,       // tiny overlap of slices
){
    astep=90/slices;
    hull()for(o = offset)
       translate([o[0],o[1],abs(b)-eps])cylinder(r=r,h=h-abs(b)-abs(t)+2*eps);
    if(b)for(a=[0:astep:89.999])hull()for(o = offset)
       translate([o[0],o[1],abs(b)-abs(b)*sin(a+astep)-eps])
          cylinder(r2=r+(1-cos(a))*b,r1=r+(1-cos(a+astep))*b,h=(sin(a+astep)-sin(a))*abs(b)+2*eps);
    if(t)for(a=[0:astep:89.999])hull()for(o = offset)
       translate([o[0],o[1],h-abs(t)+abs(t)*sin(a)-eps])
          cylinder(r1=r+(1-cos(a))*t,r2=r+(1-cos(a+astep))*t,h=(sin(a+astep)-sin(a))*abs(t)+2*eps);
}

// now build David's example, the cube with the chamfered hole (viewed from below to make things easy...)
$fn=36;
difference(){
   translate([-12.5,-12.5,0])cube(25);
   chamfercyl(3,25,3,3,[[-2,0],[2,0]]);
}


module fillet_cylinder(
 r,      // cylinder radius
 h,      // cylinder height
 b=0,    // bottom chamfer radius (=0 none, >0 outside, <0 inside)
 t=0,    // top chamfer radius (=0 none, >0 outside, <0 inside,
 deg=10  // degrees per rib of fillet
)
 rotate_extrude()
  polygon(concat([[0,h],[0,0]],
   [for(a=[0:deg:90]) [r-b*(sin(a)-1), abs(b)*(1-cos(a))]],       //bottom fillet
   [for(a=[90:-deg:0]) [r-t*(sin(a)-1), h-abs(t)*(1-cos(a))]]));  //top fillet
