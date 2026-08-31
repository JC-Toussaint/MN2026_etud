Lp=2;
Lm=2;
a=1.;

cl1 = 0.05;
r=0.75;

// XY plane
Point(1) = { 0,    0,  0, cl1};
Point(2) = { 0,  +Lp,  0, cl1};
Point(3) = { 0,  -Lm,  0, cl1};

Point(4) = { a,  +Lp, 0, cl1};
Point(5) = { a,  -Lm, 0, cl1};

Point(6) = { a,    0,   0, cl1};
Point(7) = { a,    r,   0, cl1};
Point(8) = { a,   -r,   0, cl1};
Point(9) = { a-r,  0,   0, cl1};

Line(1) = {4, 7};
Line(2) = {8, 5};

Circle(3) = {7, 6, 9};
Circle(4) = {9, 6, 8};

Line(5) = {5, 3};
Line(6) = {3, 1};
Line(7) = {1, 2};
Line(8) = {2, 4};
Line Loop(9) = {7, 8, 1, 3, 4, 2, 5, 6};
Plane Surface(10) = {9};


Symmetry {1, 0, 0, 0.} {
  Duplicata { Surface{10}; }
}
Physical Surface(1) = {11};
Physical Surface(2) = {10};
Physical Line(3) = {13, 8};
Physical Line(4) = {18, 5};
