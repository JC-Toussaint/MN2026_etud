% rk2(@equadif,[ti tf dt],[y1i y2i y3i], options);
% methode Runge et Kutta explicite ordre 2
%
function [tvec, yvec]=rk2(f, param, y0, options)
% intervalle d'etude en temps et pas
t0 = param(1);
tf = param(2);
h  = param(3);

% sauvegarde du vecteur y0 
% dans la 1ere ligne du tableau yvec 
n=1;
tvec(n) = t0;
yvec(n, :) = y0;

t = t0;
y = y0;

while (t<tf)  
    %calcul des derivees en debut de pas
    f1=f(t, y);
    
    %calcul des valeurs en milieu de pas
    t2=t+h/2;
    y2=y+(f1*h/2);
    f2=f(t2,y2);
    
    % calcul de la valeur globale
    dy=h*f2;    
    y=y+dy;    % prime = transposee
    
    n=n+1;
% pas suivant    
    t=t+h;   
 % stockage    
    tvec(n)=t;
    yvec(n, :)=y;
end


