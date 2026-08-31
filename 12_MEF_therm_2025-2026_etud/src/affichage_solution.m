function affichage_solution(fem)

h=figure(3);
hold off;
set(h, 'Position',[550 350 500 400]);

NP=fem.NP;
noeud=fem.noeud;
for i=1:NP
    x(i)=fem.noeud(i).x;
    y(i)=fem.noeud(i).y;
end
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

% figure(2);
% T=X';
% affichage resultat
 trisurf(connec,x,y,fem.sol);
% 
% f = findobj('Type','surface');
% set(f,'FaceLighting','phong');
% 
% material shiny
 shading interp
% light('Position',[0 -1 2])
% 
 colorbar;
 colormap jet;
 view(2);
 