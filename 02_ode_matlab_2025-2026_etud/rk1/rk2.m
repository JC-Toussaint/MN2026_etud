% rk2(@equadif,[ti tf dt],[y1i y2i y3i], options);
% methode d'Euler explicite ordre 1
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
    tmid = t +h/2;
    ymid = y +h/2*f(t, y);
    y = y + h*f(tmid, ymid);
    
    n=n+1;
% pas suivant    
    t=t+h;    

 % stockage    
    tvec(n)=t;
    yvec(n, :)=y;

end


