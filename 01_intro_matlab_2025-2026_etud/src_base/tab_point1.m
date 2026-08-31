function tab_point1
clc
nom='tab.dat'
[t, ier]=lecture(nom);
if (ier==1)
   error('erreur lecture');
end;

plot(t.x, t.y)

function [tab, err]=lecture(nomfich)
clear tab;

fich = fopen(nomfich);
if ( fich == -1 )
     errordlg(['Nom de fichier invalide : ' nomfich]); % ne s'arrete pas
     err = 1;
else
    % lecture commentaire
    comment = fscanf(fich, '%s', [1])
    
    % lecture du nombre de points
    tab.NP = fscanf(fich,'%d', [1]) % [1] une seule valeur scalaire

    % lecture commentaire
    comment = fscanf(fich, '%s', [1])
    
    %Lecture des coordonnees des points
    for np=1:tab.NP 
        n = fscanf(fich,'%d', [1])
        x = fscanf(fich,'%g', [1])
        y = fscanf(fich,'%g', [1])
        tab.x(n)=x;
        tab.y(n)=y;
    end;
    err = 0;
end;    
fclose(fich);

