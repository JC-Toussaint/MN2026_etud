function [gauss]=ai_gradai_T3(fem,ne,x0,y0)

clear gauss;

% traitement de l'element e=fem.elt(ne)
e=fem.elt(ne);
NBN=e.NBN;

%Premier noeud
num = e.ind(1);
x1  = fem.noeud(num).x;
y1  = fem.noeud(num).y;

%Deuxieme noeud
num = e.ind(2);
x2  = fem.noeud(num).x;
y2  = fem.noeud(num).y;

%Troisieme noeud
num = e.ind(3);
x3  = fem.noeud(num).x;
y3  = fem.noeud(num).y;

%Double de la surface de l'element 
surf2 = x2*y3-x3*y2 + x3*y1-x1*y3 + x1*y2-x2*y1;
gauss.detJ(1)=0.5*surf2;

%Point de calcul 
NPI = 1;
xg(1) = x0; 
yg(1) = y0;

gauss.NPI=NPI;
gauss.x=xg;
gauss.y=yg;

%calcul des polynomes de Lagrange et de leur gradient 
%aux points de la grille
x = xg(1);
y = yg(1);

a = (x2*y3-x3*y2) /surf2;
b = (y2-y3)       /surf2;
c = (x3-x2)       /surf2;

alpha(1,1) = a + b*x + c*y;
dalpha_dx(1,1) = b;
dalpha_dy(1,1) = c;

a = (x3*y1-x1*y3) /surf2;
b = (y3-y1)       /surf2;
c = (x1-x3)       /surf2;
alpha(2,1) = a + b*x + c*y;
dalpha_dx(2,1) = b;
dalpha_dy(2,1) = c;

a = (x1*y2-x2*y1) /surf2;
b = (y1-y2)       /surf2;
c = (x2-x1)       /surf2;
alpha(3,1) = a + b*x + c*y;
dalpha_dx(3,1) = b;
dalpha_dy(3,1) = c;

gauss.alpha=alpha;
gauss.dalpha_dx=dalpha_dx;
gauss.dalpha_dy=dalpha_dy;
end
