function dy = oscil(t,y)
dy = zeros(1,2);    % vecteur ligne

% 1er cas
%n=1.5;
%p2=2;

%2eme cas
n=0.2;
p2=1;

% changement de variable 
% pour garder les notations de l'équation
x=y(1);
v=y(2);

% écriture de l'équation telle quelle
dx_dt = v;
dv_dt = -p2*x-2*n*v;

% changement de variable pour 
% se conformer au vecteur de sortie dy
dy(1)=dx_dt;
dy(2)=dv_dt;
