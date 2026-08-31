function [gauss]=polynomes_T3(fem,ne)
% Calcul des polynomes aux points d'integration
% Polynomes dans un element triangulaire a l ordre 1
% Calcul du determinant de la matrice Jacobienne aux npi
% points d integration --> gauss.detJ

% Nombre de noeuds dans l'element e
NBN=fem.elt(ne).NBN;

% Nombre de points d integration
NPI=1;

switch NPI
case 1
    % Coordonnees du point d integration
	u   = [1.0/3.0] ;
	v   = [1.0/3.0] ;
    % poids de Gauss
	pds = [0.5] ;
case 3
    % Coordonnees des 3 points d integration
    u   = [1./6. 2./3. 1./6.];
    v   = [1./6. 1./6. 2./3.];
    % poids de Gauss
    pds = [1./6. 1./6. 1./6.];
end
    
%calcul des polynomes de Lagrange et de leurs gradients 
% aux points d integration
for npi=1:NPI
   % Polynomes aux noeuds I,II et III
   alpha(1,npi)=(1-u(npi)-v(npi));
   alpha(2,npi)=u(npi);
   alpha(3,npi)=v(npi);  
end

dalpha_du=zeros(NBN,NPI);
dalpha_dv=zeros(NBN,NPI);

% derivees polynomes de Lagrange P1 dans l'element de reference
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
end

%=======================================================================
%Calcul du determinant de la matrice Jacobienne aux points d integration
%Stockage dans la structure gauss.detJ
%=======================================================================
% detJ : determinant de [J]
detJ=zeros(NPI,1);

for ie=1:NBN
    xp(ie)  = fem.noeud(fem.elt(ne).ind(ie)).x;
    yp(ie)  = fem.noeud(fem.elt(ne).ind(ie)).y;
end

for npi=1:NPI
    % nombre de noeuds dans l element ne
    NBN=fem.elt(ne).NBN;
    dx_du = 0.;
    dx_dv = 0.;

    dy_dv = 0.;
    dy_du= 0.;

    for ie = 1:NBN
        dx_du = dx_du + dalpha_du(ie,npi)*xp(ie);
        dx_dv = dx_dv + dalpha_dv(ie,npi)*xp(ie);

        dy_dv = dy_dv + dalpha_dv(ie,npi)*yp(ie);	 
        dy_du = dy_du + dalpha_du(ie,npi)*yp(ie);	 
    end
    
    % Matrice Jacobienne transposee
    J=[dx_du dy_du;
       dx_dv dy_dv];

    % Calcul du determinant de la matrice Jacobienne aux npi
    detJ(npi)=det(J);        
end

gauss.NPI=NPI; 		% nombre de points de Gauss 
gauss.detJ=detJ;	% tableau = valeur de detJ(k) 
			% k numero du point de Gauss 
gauss.pds=pds;		% tableau = valeur de w(k)
gauss.alpha=alpha;	% matrice = gauss.alpha(ie, k) ie dans {I, II}, 
                    % k dans [1, gauss.NPI]

end