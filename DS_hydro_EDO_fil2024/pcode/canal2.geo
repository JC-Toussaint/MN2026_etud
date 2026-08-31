R=0.01;

lc1=0.5e-3;
lc2=0.2e-3;

p=newp; Point(p)={ 0,  0, 0, lc1};
p=newp; Point(p)={ R,  0, 0, lc2};
p=newp; Point(p)={ 0,  R, 0, lc2};
p=newp; Point(p)={-R,  0, 0, lc2};
p=newp; Point(p)={ 0, -R, 0, lc2};

g=0.1*R;

p=newp; Point(p)={ R-g,  0, 0, lc1};
p=newp; Point(p)={ 0,  R-g, 0, lc1};
p=newp; Point(p)={-R+g,  0, 0, lc1};
p=newp; Point(p)={ 0, -R+g, 0, lc1};

Circle(1) = {2, 1, 3};
Circle(2) = {3, 1, 4};
Circle(3) = {4, 1, 5};
Circle(4) = {5, 1, 2};

Circle(7) = {6, 1, 7};
Circle(8) = {7, 1, 8};
Circle(9) = {8, 1, 9};
Circle(10) = {9, 1, 6};

Line Loop(11) = {8, 9, 10, 7};
Plane Surface(12) = {11};
Line Loop(13) = {2, 3, 4, 1};
Plane Surface(14) = {11, 13};

Physical Surface(1) = {12, 14};
Physical Line(2) = {2, 3, 4, 1};
