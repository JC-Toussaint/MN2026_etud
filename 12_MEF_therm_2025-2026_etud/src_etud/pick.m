% interpolation de l'inconnue et du gradient en un point x0, y0
% a partir de la solution stockee dans la structure fem
% [val,grad_val_x,grad_val_y, err]=pick(fem, x0, y0);

function [val,grad_val_x,grad_val_y, err]=pick(fem, x0, y0)

% determination du premier element contenant le point x0, y0
noeud=fem.noeud;
NE=fem.NE;
for ne=1:NE
    e=fem.elt(ne);
    NBN=e.NBN;
    if (e.TYP==2)
        if (NBN~=3)
           message=strcat('Algorithme non adapte a l''element ', num2str(ne));
           questdlg(message,'  ','OK','OK');
           err=1;
           return;
        end   
        for je=1:NBN
            num=e.ind(je);
            x(je)=noeud(num).x;
            y(je)=noeud(num).y;           
        end 
        det=(x(2)-x(1))*(y(3)-y(1))-(x(3)-x(1))*(y(2)-y(1));
        surf2=abs(det);
        s2=0;

        for je=1:NBN
            jp1=mod(je,NBN)+1;
            det=(x(je)-x0)*(y(jp1)-y0)-(x(jp1)-x0)*(y(je)-y0);
            s2=s2+abs(det);
        end

        
        if abs(1-s2/surf2)<0.001 % l'element est identifie => sortie de boucle

            val=0;
            grad_val_x=0;
            grad_val_y=0;
            
            % recherche des polynomes et des gradients au point (x0,y0)
            gauss=ai_gradai_T3(fem,ne,x0,y0);
            
            % calcul de l inconnue et des gradients au point (x0,y0)
			for ie=1:NBN
                alphai = gauss.alpha(ie,1);
                dalphai_dx = gauss.dalpha_dx(ie,1);
                dalphai_dy = gauss.dalpha_dy(ie,1);

                i=e.ind(ie);
                val=val+alphai*fem.sol(i);
                grad_val_x=grad_val_x+dalphai_dx*fem.sol(i);
                grad_val_y=grad_val_y+dalphai_dy*fem.sol(i);
            end
            err=0;    
            return    
        end   
    end
end

%sortie de boucle, erreur (x0, y0) n'appartient a aucun element
val=0;
grad_val_x=0;
grad_val_y=0;
err=1;