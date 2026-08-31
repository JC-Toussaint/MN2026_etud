% expression analytique de la temperature 

function [err]=analytique(fem)

hold off;

Ri=10;
Re=50;
kth1=400;
kth2=200;

qth=1e3;
hcv=10;
Ta=300;

a1=-qth/(6*kth1);
a2=2*kth1/kth2*(Ri^3)*a1;
b2=a2/Re+Ta+qth/(3*hcv)*(Ri^3)/(Re^2);
b1=-a2/Ri-a1*Ri^2+b2;

NP=fem.NP;
x = zeros(NP,1);
y = zeros(NP,1);
T =zeros(NP,1);

a=0.2;
%%% DEBUT DU BLOC A RECOPIER DANS VOTRE COPIE %%%    

for i=1:NP
    x(i)=fem.noeud(i).x;
    y(i)=fem.noeud(i).y;
    r=sqrt(x(i)^2+y(i)^2);
    t=atan2(y(i), x(i));
    
    if r<Ri
	   T(i)=a1*r^2+b1;
	else
	   T(i)=-a2/r+b2;
	end;

end;

%%% FIN DU BLOC A RECOPIER DANS VOTRE COPIE %%%

Coord=[x' y'];

NE=fem.NE;
connec=zeros(1, 3);

i=0;
for ne=1:NE
    e=fem.elt(ne);
    if (e.TYP==2)
    i=i+1;    
    connec(i,:)=fem.elt(ne).ind;
    end;
end;

figure

% affichage resultat
 trisurf(connec,x,y,T);
% 
% f = findobj('Type','surface');
% set(f,'FaceLighting','phong');
% 
% material shiny
 shading interp

% light('Position',[0 -1 2])
% 
 colorbar;
 view(2);
