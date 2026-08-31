% euler avec dy/dt=-y^2
% [tvec, yvec]=euler(param, y0)
%
function [tvec, yvec]=euler(param, y0)

% intervalle d'etude en temps et pas
t0 = param(1);
tf = param(2);
h  = param(3);

% creation des tableaux tvec et yvec lors de l'affectation 
n=1;
tvec(n) = t0;
yvec(n) = y0;

t = t0;
y = y0;

while (t<tf)
    % calcul de y_n+1 en fct de y_n
    y=y-h*y*y;
    
    % au temps n+1
    n=n+1;
    t=t+h;
    
     % stockage, redim gere par matlab    
    tvec(n)=t;
    yvec(n)=y;
end

end    