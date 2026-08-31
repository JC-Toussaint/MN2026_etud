% [gauss]=polynomes_T3(fem, ne)
% polynomes P1 de Lagrange d'ordre 1 et derivees sur l'element triangulaire ne
% calcules aux points de Gauss
% Entree/
% structure fem et le numero ne de l'element triangulaire a traiter
% Sortie/
% gauss.NPI	: nombre de points d intégration
% gauss.pds(npi)	: poids du point de gauss npi
% gauss.alpha(ie,npi) : polynome du noeud ie au point de gauss npi
% gauss.dalpha_dx(ie,npi) : derivee /à x du polynome du noeud ie au point de gauss npi
% gauss.dalpha_dy(ie,npi) : derivee /à y du polynome du noeud ie au point de gauss npi
% gauss.detJ(npi) : déterminant de la matrice Jacobienne au point d'intégration npi

function [gauss]=polynomes_T3(fem, ne)

clear gauss;

% traitement de l'element e=fem.elt(ne)
e=fem.elt(ne);
NBN=e.NBN;

% Nombre de Points d'integration de Gauss 
% Coordonnees des points de Gauss et poids
NPI = 3;
u   = [1./6. 2./3. 1./6.];
v   = [1./6. 1./6. 2./3.];
pds = [1./6. 1./6. 1./6.];
    
% polynomes de Lagrange P1
for npi=1:NPI
    alpha(1, npi)=1-u(npi)-v(npi);
    alpha(2, npi)=u(npi);
    alpha(3, npi)=v(npi);
end;

% alpha(ie,1:NPI) polynomes de Lagrange associé au noeud ie 
% evalués aux NPI points d'integration
gauss.alpha=alpha;
gauss.NPI=NPI;
gauss.pds=pds;

% derivees polynomes de Lagrange P1 dans l'element de reference
dalpha_du=zeros(NBN,NPI);
dalpha_dv=zeros(NBN,NPI);

for npi=1:NPI
    % dalpha_du(ie, npi) derivee par rapport a u 
    % du polynome de Lagrange calculee au point de Gauss npi
    dalpha_du(1, npi)=-1;
    dalpha_du(2, npi)=+1;
    dalpha_du(3, npi)= 0;

    % dalpha_dv(ie, npi) derivee par rapport a v 
    % du polynome de Lagrange calculee au point de Gauss npi
    dalpha_dv(1, npi)=-1;
    dalpha_dv(2, npi)= 0;
    dalpha_dv(3, npi)=+1;
end;

% coordonnees des noeuds de l'element e
xp=zeros(NBN, 1);
yp=zeros(NBN, 1);

for ie=1:NBN
    num = e.ind(ie);
    xp(ie)  = fem.noeud(num).x;
    yp(ie)  = fem.noeud(num).y;
end

% transformation vers l'element reel avec calcul du jacobien
J=zeros(2,2,NPI);
detJ=zeros(NPI,1);
dalpha_dx=zeros(NBN,NPI);
dalpha_dy=zeros(NBN,NPI);

for npi=1:NPI
    dx_du=0.;
    dx_dv=0.;

    dy_du=0.;
    dy_dv=0.;

    for ie=1:NBN
        dx_du=dx_du+dalpha_du(ie, npi)*xp(ie);
        dx_dv=dx_dv+dalpha_dv(ie, npi)*xp(ie);

        dy_du=dy_du+dalpha_du(ie, npi)*yp(ie);
        dy_dv=dy_dv+dalpha_dv(ie, npi)*yp(ie);
    end    
    
    Jt=[dx_du dy_du;
        dx_dv dy_dv];
    detJ(npi)=det(Jt);    

    if (detJ(npi)~=0) 
       invJt=inv(Jt);
    else
       error('Matrice Jacobienne non inversible!');
    end;

    for ie=1:NBN 
        %GRADIENT DANS L'ELEMENT REEL
        dalphai_du=dalpha_du(ie, npi);
        dalphai_dv=dalpha_dv(ie, npi);
        
        gradai=invJt*[dalphai_du; dalphai_dv];
        
        dalpha_dx(ie, npi)=gradai(1);
        dalpha_dy(ie, npi)=gradai(2); 
    end;
end;

gauss.detJ=detJ;
gauss.dalpha_dx=dalpha_dx;  % dalpha_dx(ie, k) ie=I..NBN k=1..NPI
gauss.dalpha_dy=dalpha_dy;













