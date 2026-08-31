function [fem, err]=lecture_probleme(nomfich)

clear fem;

fich = fopen(nomfich);
if ( fich == -1 )
     message=strcat('Nom de fichier invalide :',nomfich);
     questdlg(message,'  ','OK','OK');
     err = 1;
else
    %Lecture des coordonnees des noeuds
    comment = fscanf(fich,'%s',[1]);
    fem.NP = fscanf(fich,'%d',[1]); 
    for np=1:fem.NP 
        n = fscanf(fich,'%d',[1]);
        noeud.x=fscanf(fich,'%f',[1]);
        noeud.y=fscanf(fich,'%f',[1]);
        fem.noeud(n)=noeud;
    end;

   %Lecture des informations relatives aux elements surfaciques & lineiques
    comment = fscanf(fich,'%s',[1]);
    fem.NE = fscanf(fich,'%d',[1]);
    for ne=1:fem.NE 
        elt.TYP = fscanf(fich,'%d',[1]);
        elt.NBN = fscanf(fich,'%d',[1]);
        elt.NRG = fscanf(fich,'%d',[1]);
        for nbn=1:elt.NBN
            elt.ind(nbn)=fscanf(fich,'%d',[1]);
        end;
        fem.elt(ne)=elt;           
    end;    
  
   %Lecture du nombre de regions et des affectations
    comment  = fscanf(fich,'%s',[1]);
    fem.NRG = fscanf(fich,'%d',[1]);
    for nrg=1:fem.NRG
        fem.equ.sigma(nrg)=fscanf(fich,'%f',[1]);
        fem.equ.jn(nrg)=fscanf(fich,'%f',[1]); 
    end

    %Lecture des conditions aux limites de Dirichlet
    comment = fscanf(fich,'%s',[1]);
    fem.NCLD = fscanf(fich,'%d',[1]);
    fem.cld=0;
    
    for npc=1:fem.NCLD         
        cld.ind(npc)=fscanf(fich,'%d',[1]);
        cld.val(npc)=fscanf(fich,'%f',[1]);
        fem.cld=cld;
    end;
    
    err = 0;
end;

