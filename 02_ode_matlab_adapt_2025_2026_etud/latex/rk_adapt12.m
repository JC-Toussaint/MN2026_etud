% rk_adapt12(@equadif,[ti tf dt],[y1i y2i y3i], options);
% methode d'Euler a pas adaptatif 
%

function [tvec, yvec]=rk_adapt12(f, param, y0, options)
AbsTol=1e-6;
% intervalle d'etude en temps et pas
t0 = param(1);
tf = param(2);
h  = param(3);

% sauvegarde du vecteur y0 dans la 1ere ligne du tableau yvec 
n=1;
tvec(n)    = t0;
yvec(n, :) = y0;

t = t0;
y = y0;

while (t<tf)  
    f1=f(t, y);
    f2=f(t+h/2., y+h/2.*k1);
     
    A1=y + h*f1;    % RK1
    A2=y + h*f2;    % RK2
    
    E=A1-A2;
    norm_E=norm(E, inf);
    h=0.9*sqrt(AbsTol/norm_E)*h;

    if (norm_E <= AbsTol) 
        % pas suivant    
        t=t+h; 
        n=n+1;       
        y=A2; 

% stockage    
        tvec(n)=t;
        yvec(n, :)=y; 
    end   
end


