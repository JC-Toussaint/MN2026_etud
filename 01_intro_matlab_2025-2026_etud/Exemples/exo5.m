clear
[X,Y]=meshgrid(-1:0.05:1,-1:0.05:1);
Z=5*exp(0.4*X).*sin(7.5*Y);
mesh(X,Y,Z)
%surf(X,Y,Z)
