% rk1(@equadif,[ti tf dt],[y1i y2i y3i], options);
% methode d'Euler explicite ordre 1
%

function [tvec, yvec]=rk1(f, param, y0)
% intervalle d'etude en temps et pas
t0 = param(1);
tf = param(2);
h  = param(3);

% sauvegarde du vecteur y0 
% dans la 1ere ligne du tableau yvec 
n=1;
tvec(n) = t0;
yvec(n, :) = y0;

t = t0;  % a l'instant n
y = y0;

while (t<tf)  
    % schema euler
    % y_n+1 = y_n + h f(t_n, y_n)
    % A COMPLETER   
    
    % pas suivant 
    n=n+1;   
    t=t+h;    

 % stockage    
    tvec(n) = t;
    yvec(n, :)=y;

end
return % optionnel
end


