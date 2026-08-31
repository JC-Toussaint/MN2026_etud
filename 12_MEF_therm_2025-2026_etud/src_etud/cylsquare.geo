cl=0.03;

Point(1) = {0, 0, 0, cl};
Point(2) = {0.5, 0, 0, cl};
Point(3) = {-0.5, 0, 0, cl};
Point(4) = {0, 0.5, 0, cl};
Point(5) = {0, -0.5, 0, cl};
Point(6) = {-1, -1, 0, cl};
Point(7) = {1, -1, 0, cl};
Point(8) = {1, 1, 0, cl};
Point(9) = {-1, 1, 0, cl};

Circle(1) = {2, 1, 4};
Circle(2) = {4, 1, 3};
Circle(3) = {3, 1, 5};
Circle(4) = {5, 1, 2};

Line(5) = {6, 7};
Line(6) = {7, 8};
Line(7) = {8, 9};
Line(8) = {9, 6};

Line Loop(9) = {7, 8, 5, 6};
Line Loop(10) = {2, 3, 4, 1};
Plane Surface(11) = {9, 10};
Plane Surface(12) = {10};

Physical Surface(1) = {12};
Physical Surface(2) = {11};
Physical Line(3) = {6, 7, 8, 5};
