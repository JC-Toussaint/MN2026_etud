clc
kth = phys.kth;
Tad = phys.Tad;
Tdg = phys.Tdg;
hd =  phys.hd;

L =0.2;

A = [L     -1;
    kth/hd  1];

b = [-Tdg; 
     +Tad];
 
sol = A\b