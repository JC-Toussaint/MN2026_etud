function [gauss]=polynomes_L2(fem, ne)

% Nombre de noeuds dans l'element e
NBN=fem.elt(ne).NBN;

% Nombre de points d integration
NPI=2;

% Coordonnees des 2 points d integration
u   = [-1/sqrt(3) 1/sqrt(3)];

% poids de Gauss w_k
pds = [1. 1.];     

%calcul des polynomes de Lagrange aux points d'integration
for k=1:NPI
   % Polynomes aux noeuds I,II
   alpha(1, k)=(1-u(k))/2;  % L(1, k)
   alpha(2, k)=(1+u(k))/2;  % L(2, k)
end

dalpha_du=zeros(NBN,NPI);

% derivees polynomes de Lagrange P1 dans l'element de reference
for k=1:NPI
    % dalpha_du(ie, k) derivee par rapport a u 
    % du polynome de Lagrange calculee au point de Gauss k
    dalpha_du(1, k)=-0.5;
    dalpha_du(2, k)=+0.5;
end

% detJ : determinant de la matrice Jacobienne aux points d integration
detJ=zeros(NPI,1);
% Abscisse des points de Gauss
xg=zeros(1, NPI);

e=fem.elt(ne);
for ie=1:NBN % I puis II
    iglobal=e.ind(ie); % passage local --> global
    xp(ie)  = fem.noeud(iglobal).x; % x_I et x_II
end


for k=1:NPI % boucle sur les points de Gauss
    x = 0.;
    dx_du = 0.;
    for ie = 1:NBN
        x=x+alpha(ie, k)*xp(ie);
        dx_du = dx_du + dalpha_du(ie, k)*xp(ie);
    end

    % abscisse du point de Gauss k
    xg(k)=x;
    
    % determinant de la matrice Jacobienne au point de Gauss k
    detJ(k)=dx_du;    
end

gauss.NPI=NPI; 		% nombre de points de Gauss = 2

gauss.detJ=detJ;	% tableau = valeur de detJ(k) k numero du point de Gauss 

gauss.pds=pds;		% tableau = valeur de w(k)

gauss.alpha=alpha;	% matrice = gauss.alpha(ie, k) ie dans {I, II}, k dans [1, gauss.NPI]

gauss.x=xg;		% tableau = gauss.x(k) abscisse du point de Gauss k dans l'element reel












