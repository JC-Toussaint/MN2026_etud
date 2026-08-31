R=0.01;

lc=2e-3;

p=newp; Point(p)={ 0,  0, 0, lc};
p=newp; Point(p)={ R,  0, 0, lc};
p=newp; Point(p)={ 0,  R, 0, lc};
p=newp; Point(p)={-R,  0, 0, lc};
p=newp; Point(p)={ 0, -R, 0, lc};

Circle(1) = {2, 1, 3};
Circle(2) = {3, 1, 4};
Circle(3) = {4, 1, 5};
Circle(4) = {5, 1, 2};
Line Loop(5) = {2, 3, 4, 1};
Plane Surface(6) = {5};

Physical Surface(1) = {6};
Physical Line(2) = {2, 3, 4, 1};
