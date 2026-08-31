function [fem, err]=lecture_probleme(nomfich)

fem.name=nomfich;

fich = fopen(nomfich);
if ( fich == -1 )
    message=strcat('Nom de fichier invalide :',nomfich);
    questdlg(message,'  ','OK','OK');
    err = 1;
    fclose(fich);
else
    %Lecture des coordonnees des noeuds
    comment = fscanf(fich,'%s',[1]);
    fem.NP = fscanf(fich,'%d',[1]);
    for np=1:fem.NP
        n = fscanf(fich,'%d',[1]);
        x = fscanf(fich,'%f',[1]);
        y = fscanf(fich,'%f',[1]);
        fem.noeud(n).x=x;
        fem.noeud(n).y=y;
    end
    
    %Lecture des informations relatives aux elements surfaciques & lineiques
    comment = fscanf(fich,'%s',[1]);
    fem.NE = fscanf(fich,'%d',[1]);
    bary=zeros(fem.NE, 2);
    for ne=1:fem.NE
        elt.TYP = fscanf(fich,'%d',[1]);
        elt.NBN = fscanf(fich,'%d',[1]);
        elt.NRG = fscanf(fich,'%d',[1]);
        Gx=0;
        Gy=0;
        for ie=1:elt.NBN
            np=fscanf(fich,'%d',[1]);
            elt.ind(ie)=np;
            Gx=Gx+fem.noeud(np).x;
            Gy=Gy+fem.noeud(np).y;
        end
        fem.elt(ne)=elt;
        if (elt.TYP==2)
            bary(ne, 1)=Gx/elt.NBN;
            bary(ne, 2)=Gy/elt.NBN;
        else
            bary(ne, 1)=Inf;
            bary(ne, 2)=Inf;
        end
    end
    fem.bary=bary;
    
    %Lecture du nombre de regions et des affectations
    comment  = fscanf(fich,'%s',[1]);
    fem.NRG = fscanf(fich,'%d',[1]);
    
    for nrg=1:fem.NRG        
%%% DEBUT DU BLOC A RECOPIER DANS VOTRE COPIE %%%     
% A ADAPTER
        fem.equ.kth(nrg) =fscanf(fich,'%f',[1]);
        fem.equ.qth(nrg) =fscanf(fich,'%f',[1]);
        fem.equ.hcv(nrg) =fscanf(fich,'%f',[1]);
        fem.equ.Ta(nrg)  =fscanf(fich,'%f',[1]);
% A COMPLETER

%%% FIN DU BLOC A RECOPIER DANS VOTRE COPIE %%%
    end
    
    %Lecture des conditions aux limites de Dirichlet
    comment = fscanf(fich,'%s',[1]);
    fem.NCLD = fscanf(fich,'%d',[1]);
    fem.cld=0;
    
    for npc=1:fem.NCLD
        cld.ind(npc)=fscanf(fich,'%d',[1]);
        cld.val(npc)=fscanf(fich,'%f',[1]);
        fem.cld=cld;
    end
    
    fclose(fich);
    err = 0;
end

