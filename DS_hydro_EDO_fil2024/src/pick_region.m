% identification de la region
% [val, err]=pick_region(fem, x0, y0);

function [val,grad_val_x,grad_val_y, err]=pick(fem, x0, y0)

% determination du premier element contenant le point x0, y0
noeud=fem.noeud;
NE=fem.NE;
for ie=1:NE
    e=fem.elt(ie);
    if (e.TYP==2)
        NBN=e.NBN; 
        if (NBN~=3)
           message=strcat('Algorithme non adapte a l''element ', num2str(ie));
           questdlg(message,'  ','OK','OK');
           err=1;
           return;
        end;   
        for j=1:NBN
            num=e.ind(j);
            x(j)=noeud(num).x;
            y(j)=noeud(num).y;           
        end; 
        det=(x(2)-x(1))*(y(3)-y(1))-(x(3)-x(1))*(y(2)-y(1));
        surf2=abs(det);
        s2=0;

        for j=1:NBN
            jp1=mod(j,NBN)+1;
            det=(x(j)-x0)*(y(jp1)-y0)-(x(jp1)-x0)*(y(j)-y0);
            s2=s2+abs(det);
        end;

        
        if abs(1-s2/surf2)<0.001 % l'element est identifie => sortie de boucle
            e.ind
            val=e.NRG;
            err=0;    
            return    
        end;   
    end;
end;

% si erreur
val=0;
err=1;