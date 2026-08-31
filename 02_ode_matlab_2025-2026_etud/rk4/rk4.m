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
    % A COMPLETER
    
    n=n+1;
 
% pas suivant    
    t=t+h;    
% stockage    
    tvec(n)=t;
    yvec(n, :)=y;    
end


