function [gauss]=polynomes_L2(fem,ne)

% Nombre de noeuds dans l'element e
NBN=fem.elt(ne).NBN;

% Nombre de points d integration
NPI=2;

% Coordonnees des 2 points d integration
u   = [-1/sqrt(3) 1/sqrt(3)];
% poids de Gauss
pds = [1. 1.];

%calcul des polynomes de Lagrange aux points d'integration
for npi=1:NPI
   % Polynomes aux noeuds I,II
   alpha(1,npi)=(1-u(npi))/2;
   alpha(2,npi)=(1+u(npi))/2;  
end;

dalpha_du=zeros(NBN,NPI);

% derivees polynomes de Lagrange P1 dans l'element de reference
for npi=1:NPI
    % dalpha_du(ie, npi) derivee par rapport a u 
    % du polynome de Lagrange calculee au point de Gauss npi
    dalpha_du(1, npi)=-0.5;
    dalpha_du(2, npi)=+0.5;
end;

% detJ : determinant de la matrice Jacobienne aux points d integration
detJ=zeros(NPI,1);
% Abscisse des points de Gauss
xg=zeros(1, NPI);

for ie=1:NBN
    e=fem.elt(ne);
    iglobal=e.ind(ie);
    xp(ie)  = fem.noeud(iglobal).x;
end

for npi=1:NPI
    x = 0.;
    dx_du = 0.;
    for ie = 1:NBN
        x=x+alpha(ie, npi)*xp(ie);
        dx_du = dx_du + dalpha_du(ie,npi)*xp(ie);
    end

    % abscisse du point de Gauss npi
    xg(npi)=x;
    
    % determinant de la matrice Jacobienne au point npi
    detJ(npi)=dx_du;    
end;

gauss.NPI=NPI;          % nombre de points de Gauss = 2

gauss.detJ=detJ;        % tableau = valeur de detJ(k)
                        % k numero du point de Gauss 

gauss.pds=pds;          % tableau = valeur de w(k)

gauss.alpha=alpha;      % matrice = gauss.alpha(ie, k) 
                        % ie dans {I, II}, k dans [1, gauss.NPI]

gauss.x=xg;             % tableau = gauss.x(k) abscisse du point de 
                        % Gauss k dans l'element reel












