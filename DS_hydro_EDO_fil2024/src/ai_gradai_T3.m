function [gauss, err]=ai_gradai_T3(fem,ne,x0,y0)

clear gauss;
gauss.NPI=1;

% traitement de l'element ne
e=fem.elt(ne);
NBN=e.NBN;

for ie=1:NBN
    np=e.ind(ie);
    x(ie)=fem.noeud(np).x;
    y(ie)=fem.noeud(np).y;           
end; 

%Double de la surface de l'element 
det=(x(2)-x(1))*(y(3)-y(1))-(x(3)-x(1))*(y(2)-y(1));
surf2=abs(det);

s2=0;
for je=1:NBN
    jp1=mod(je,NBN)+1;
    det=(x(je)-x0)*(y(jp1)-y0)-(x(jp1)-x0)*(y(je)-y0);
    s2=s2+abs(det);
end;
        
eps=1e-3;
if (s2>surf2*(1.0+eps))
    err=1;
    return;
end;

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

a = (x(2)*y(3)-x(3)*y(2)) /surf2;
b = (y(2)-y(3))       /surf2;
c = (x(3)-x(2))       /surf2;

alpha(1,1) = a + b*x0 + c*y0;
dalpha_dx(1,1) = b;
dalpha_dy(1,1) = c;

a = (x(3)*y(1)-x(1)*y(3)) /surf2;
b = (y(3)-y(1))       /surf2;
c = (x(1)-x(3))       /surf2;

alpha(2,1) = a + b*x0 + c*y0;
dalpha_dx(2,1) = b;
dalpha_dy(2,1) = c;

a = (x(1)*y(2)-x(2)*y(1)) /surf2;
b = (y(1)-y(2))       /surf2;
c = (x(2)-x(1))       /surf2;

alpha(3,1) = a + b*x0 + c*y0;
dalpha_dx(3,1) = b;
dalpha_dy(3,1) = c;

    err=0;
    gauss.alpha=alpha;
    gauss.dalpha_dx=dalpha_dx;
    gauss.dalpha_dy=dalpha_dy;

