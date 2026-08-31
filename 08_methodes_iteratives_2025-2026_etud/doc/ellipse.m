% Methode du gradient conjugue
clc
close all
clear all

% systeme a resoudre
A=[2 1; 
   1 1];
b=[1 0]';

% point de depart x0
x=[1 1]';

% tolerance
tol=1e-6;

% initialisation 
r=b-A*x;
p=r;

hold off
[x,y] = meshgrid([-5:.1:5], [-5:.1:5]);
Z =0.5*(A(1,1)*x.*x+A(1,2)*x.*y+A(2,1)*y.*x+A(2,2)*y.*y)-b(1)*x-b(2)*y;
surf(x,y,Z,Z, 'FaceColor','interp')
hold on;
colorbar
en=[0, 2, 5, 10, 15, 20]
figure
Z =0.5*(A(1,1)*x.*x+A(1,2)*x.*y+A(2,1)*y.*x+A(2,2)*y.*y)-b(1)*x-b(2)*y;
[C,h] =contour(x, y, Z, en);
set(h,'ShowText','on','TextStep',get(h,'LevelStep')*2)
colormap jet
hold on;
