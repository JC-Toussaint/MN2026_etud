% [gauss]=polynomes_S2(fem, ne)
% polynomes P1 de Lagrange d'ordre 1 et derivees sur l'element lineique ne
% calcules aux points de Gauss
% Entree/
% structure fem et le numero ne de l'element lineique a traiter
% Sortie/
% gauss.NPI	: nombre de points d intégration
% gauss.pds(npi)	: poids du point de gauss npi
% gauss.alpha(ie,npi) : polynome du noeud ie au point de gauss npi
% gauss.detJ(npi) : déterminant de la matrice Jacobienne au point d'intégration npi

function [gauss]=polynomes_S2(fem, ne)

clear gauss;

% traitement de l'element e=fem.elt(ne)
e=fem.elt(ne);
NBN=e.NBN;

% nombre de points de Gauss, abscisses de Gauss et poids
NPI = 2;
u = [-1./sqrt(3.) 1./sqrt(3.)];
pds=[1.0  1.0];

% polynomes de Lagrange P1
% alpha(ie,1:NPI) polynomes de Lagrange associé au noeud ie 
% evalués aux NPI points d'integration
for npi=1:NPI
    alpha(1, npi)=0.5*(1-u(npi));
    alpha(2, npi)=0.5*(1+u(npi));
end;

gauss.NPI=NPI;
gauss.alpha=alpha; % alpha(ie, k) ie=[1:NBN] k=[1:NPI]
gauss.pds=pds;	   % pds(k)	  

% derivees polynomes de Lagrange P1 dans l'element de reference
dalpha_du=zeros(NBN,NPI);

for npi=1:NPI
    % dalpha_du(ie, npi) derivee par rapport a u 
    % du polynome de Lagrange calculee au point de Gauss npi
    dalpha_du(1, npi)=-0.5;
    dalpha_du(2, npi)=+0.5;
end

% coordonnees des noeuds de l'element e
xp=zeros(NBN, 1);
yp=zeros(NBN, 1);

for ie=1:NBN
    num = e.ind(ie);
    xp(ie)  = fem.noeud(num).x;
    yp(ie)  = fem.noeud(num).y;
end

% transformation vers l'element reel avec calcul du jacobien
detJ=zeros(NPI,1);
for npi=1:NPI
    dx_du=0.;
    dy_du=0.;

    for ie=1:NBN
        dx_du=dx_du+dalpha_du(ie, npi)*xp(ie);
        dy_du=dy_du+dalpha_du(ie, npi)*yp(ie);
    end    
    
    J=sqrt(dx_du*dx_du+dy_du*dy_du);
    detJ(npi)=J;   % cas particulier    
end

gauss.detJ=detJ;
end
