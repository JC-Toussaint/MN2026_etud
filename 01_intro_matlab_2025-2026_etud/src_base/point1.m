function point1

p=saisie();
disp(['coordonnees : ' num2str(p.x) ' ' num2str(p.y)]);


function [p]=saisie()
p.x=input('abscisse du point : ');
p.y=input('ordonnee du point : ');