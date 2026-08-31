function affichage_maillage(fem);

h=figure(1);
hold off;
set(h, 'Position',[0 0 500 400]);

NP=fem.NP;
noeud=fem.noeud;
for i=1:NP
    x(i)=noeud(i).x;
    y(i)=fem.sol(i);
end;
Coord=[x' y'];

plot(x, y, 'ro');
hold on;
plot(x, y, 'k');

numero=1:NP;
texte=num2str(numero');
text(x, y,texte,'Fontsize',16,'HorizontalAlignment','left');

NE=fem.NE;

color=[0 1 0; % vert
       1 0 0];% rouge
% boucle sur les elements
for ne=1:NE
    e=fem.elt(ne);
    NBN=e.NBN;
    TYP=e.TYP;
    xg=0;   % barycentre
    yg=0;

    for ie=1:NBN 
        num1=e.ind(ie); 
        xg=xg+x(num1);
        yg=yg+y(num1);    
    end;
    xg=xg/NBN;
    yg=yg/NBN;
    texte=num2str(ne);
    col=color(TYP,:);
    text(xg,yg,texte,'Fontsize',12,'HorizontalAlignment','left', 'BackgroundColor',col);
end;
