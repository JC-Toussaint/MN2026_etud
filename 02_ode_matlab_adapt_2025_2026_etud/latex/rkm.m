% rkm(@equadif,[ti tf dt],[y1i y2i y3i], options)
% methode de Kutta-Merson explicite ordre 5
%

function [tvec, yvec]=rkm(f, param, y0, options)
AbsTol=1e-6;
% intervalle d'etude en temps et pas
t0 = param(1);
tf = param(2);
h  = param(3);

% sauvegarde du vecteur y0 dans la 1ere ligne du tableau yvec 
n=1;
tvec(n) = t0;
yvec(n, :) = y0;

t = t0;
y = y0;

while (t<tf)  
    k1=f(t, y);
    k2=f(t+h/3., y+h/3.*k1);
    k3=f(t+h/3., y+h/6.*k1+h/6.*k2);
    k4=f(t+h/2., y+h/8.*k1+3.*h/8.*k3);  
    k5=f(t+h,    y+h/2.*k1-3./2.*h*k3+2.*h*k4);  
    
    A1=y+h/2.*(k1-3.*k3+4.*k4);
    A2=y+h/6.*(k1+4.*k4+k5);
    
    E=(A1-A2)/5.;
    norm_E=norm(E, inf);
    h=0.9*(AbsTol/norm_E)^0.2*h;  

    if (norm_E <= AbsTol) 
        % pas suivant      
        t=t+h; 
        n=n+1;
        
        y=A2-E;   
% stockage    
        tvec(n)=t;
        yvec(n, :)=y; 
    end;    
end


