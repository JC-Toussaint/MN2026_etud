function affichage_solution(fem)

h=figure;
hold off;

ratio=(fem.ymax-fem.ymin)/(fem.xmax-fem.xmin);
set(h, 'Position',[600 550 500 400*ratio]);
%set(h, 'Position',[550 350 500 400]);

NP=fem.NP;
noeud=fem.noeud;
for i=1:NP
    x(i)=fem.noeud(i).x;
    y(i)=fem.noeud(i).y;
end;
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

xmin=min(x); xmax=max(x); dx=(xmax-xmin)/50;
ymin=min(y); ymax=max(y); dy=(ymax-ymin)/50;
IX = xmin:dx:xmax;
IY = ymin:dy:ymax;

% traitement de la partie reelle
zmin=min(fem.sol); zmax=max(fem.sol);

[xi,yi] = meshgrid(IX, IY);
zi = griddata(x,y,fem.sol,xi,yi);
%[px,py] = gradient(zi,.2,.2)

[C,h] =contour3(xi, yi, zi, 21, 'k');
hold on
trisurf(connec,x,y, fem.sol);
view(2)
shading interp
%surfc(xi, yi, zi);

%set(h,'ShowText','on','TextStep',get(h,'LevelStep')*2)
colormap jet
colorbar;
title('Temperature');



