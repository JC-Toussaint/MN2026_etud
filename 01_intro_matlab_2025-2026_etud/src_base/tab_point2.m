function tab_point2
clc
nom='tab.dat'
[courbe, ier]=lecture(nom);
if (ier==1)
   error('erreur lecture');
end;

for i=1:courbe.NP
    x(i)=courbe.M(i).x;
    y(i)=courbe.M(i).y;    
end;
plot(x, y)

%plot(courbe.p(:).x, courbe.p(:).y, 'r');

function [courbe, err]=lecture(nomfich)
clear courbe;

fich = fopen(nomfich);
if ( fich == -1 )
     errordlg(['Nom de fichier invalide : ' nomfich]); % ne s'arrete pas
     err = 1;
else
    % lecture commentaire
    comment = fscanf(fich, '%s', [1])
    
    % lecture du nombre de points
    courbe.NP = fscanf(fich,'%d', [1]) % [1] une seule valeur scalaire

    % lecture commentaire
    comment = fscanf(fich, '%s', [1])
    
    %Lecture des coordonnees des points
    for np=1:courbe.NP 
        n = fscanf(fich,'%d', [1])
        x = fscanf(fich,'%g', [1])
        y = fscanf(fich,'%g', [1])
        courbe.M(n).x=x;
        courbe.M(n).y=y;
    end;
    err = 0;
    courbe
end;    
fclose(fich);

