% rk4(@equadif,[ti tf dt],[y1i y2i y3i], options)
% methode Runge et Kutta explicite ordre 4
%
 
function [tvec, yvec]=rk4(f, param, y0, options)
% intervalle d'etude en temps et pas
t0 = param(1);
tf = param(2);
h  = param(3);
 
% sauvegarde du vecteur y0 dans la 1ere ligne du tableau yvec 
n=1;
tvec(n) = t0;
yvec(n, :) = y0;
 
% Intialisation des parametres de la methode
A = [1/6; 1/3; 1/3; 1/6];
 
t = t0;
y = y0;
 
while (t<tf)  
    %calcul des derivees en debut de pas
    f1=f(t, y);
    
    %calcul des valeurs en milieu de pas : 1ere approximation
    t2=t + h/2;
    y2=y + f1*h/2;
    f2=f(t2,y2);
 
    %calcul des valeurs en milieu de pas : 2eme approximation
    y3=y + f2*h/2;
    f3=f(t2,y3);
    
    % calcul de la valeur en fin de pas
    t4=t + h;
    y4=y + f3*h;
    f4=f(t4,y4);
 
    % calcul de la valeur globale
    dy=h*(A(1)*f1+A(2)*f2+A(3)*f3+A(4)*f4);    
    y=y+dy;   
    
    n=n+1;
 
% pas suivant    
    t=t+h;    
% stockage    
    tvec(n)=t;
    yvec(n, :)=y;    
end


