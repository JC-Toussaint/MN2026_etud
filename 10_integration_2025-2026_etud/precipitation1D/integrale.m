function [Ie]=integrale(fem, ne)
% Calcul de l integrale de la fonction Ie sur l'element ne
%
% Fonction appelee
% -----------------
% polynomes_L2 :
% Calcul des polynomes sur element lineaire
% et calcul du determinant du Jacobien

% chargement des polynomes de Lagrange pour le segment a 2 noeuds
[gauss]=polynomes_L2(fem,ne);
 
NPI=gauss.NPI;
NBN=fem.elt(ne).NBN;

detJ  = gauss.detJ;  % detJ(k)   où k in [1, NPI]
pds   = gauss.pds;   % pds(k)
alpha = gauss.alpha; % alpha(ie, k) où ie in [I, NBN]

e  = fem.elt(ne);

Ie = 0;  % OBLIGATOIRE
for k = 1:NPI
    % calcul de l'interpolee Q au point de Gauss k
    Qk = 0;
    for ie = 1:NBN  % ie in [I, NBN]
        % passage de la ntation locale à globale
        iglobal = e.ind(ie);
        Qie = fem.sol(iglobal);
        Qk = Qk + Qie * alpha(ie, k);
    end
    
    Ie = Ie + Qk * detJ(k) * pds(k);
end




end

