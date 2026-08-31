function affichage_maillage(fem);

h=figure(1);
hold off;
set(h, 'Position',[0 550 500 400]);

NP=fem.NP;
noeud=fem.noeud;
for i=1:NP
    x(i)=noeud(i).x;
    y(i)=noeud(i).y;
end;
Coord=[x' y'];

numero=1:NP;
texte=num2str(numero');
text(x, y,texte,'Fontsize',16,'HorizontalAlignment','left');

NE=fem.NE;

% matrice d'adjacence pour graphes de connectivite
% A(:,:, 1) pour les elements lineiques
% A(:,:, 2) pour les elements surfaciques
A=zeros(NP, NP, 2);   
color=[0 1 0; % vert
       1 0 0];% rouge
% boucle sur les elements
for ie=1:NE
    e=fem.elt(ie);
    NBN=e.NBN;
    TYP=e.TYP;
    xg=0;   % barycentre
    yg=0;

    for j=1:NBN 
        num1=e.ind(j);
        jp1=mod(j, NBN)+1;
        num2=e.ind(jp1);  
        % matrice d'adjacence
        A(num1, num2, TYP)=1;
        A(num2, num1, TYP)=1;   
        %barycentre de l'element e
        xg=xg+x(num1);
        yg=yg+y(num1);    
    end;
    xg=xg/NBN;
    yg=yg/NBN;
    texte=num2str(ie);
    col=color(TYP,:);
    text(xg,yg,texte,'Fontsize',12,'HorizontalAlignment','left', 'BackgroundColor',col);
end;

hold on;
gplot(A(:,:,1),Coord,'-rs');
gplot(A(:,:,2),Coord,'-bo');
hold off;
%connec=zeros(1, 3);

%i=0;
%for ie=1:NE
%    e=fem.elt(ie);
%    if (e.TYP==2)
%    i=i+1;    
%    connec(i,:)=fem.elt(i).ind;
%    end;
%end;

%triplot(connec, x, y,'-bo',...
%                'LineWidth',1,...
%                'MarkerEdgeColor','k',...
%                'MarkerFaceColor',[.49 1 .63],...
%                'MarkerSize',6)
%    title('Maillage triangulaire');
