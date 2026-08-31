function [Ie]=integrale(fem,ne)

% Calcul de l integrale de la fonction (Ie) sur un element (ne)

% Fonction appelee
% -----------------
% polynomes_T3 :
% Calcul des polynomes sur element triangulaire
% et calcul du determinant du Jacobien
    
% chargement des polynomes de Lagrange pour triangles a 3 noeuds
[gauss]=polynomes_T3(fem,ne);

NPI=gauss.NPI;
alpha = gauss.alpha;  % alpha(ie, k) avec ie in [I, NBN] et k in [1, NPI]
detJ  = gauss.detJ;   % detJ(k) avec k in [1, NPI]
pds   = gauss.pds;    % w(k)    avec k in [1, NPI]

% calcul de l integrale sur 1 element
e  = fem.elt(ne);
NBN = e.NBN; % nombre de noeuds de l'element ne
TYP = e.TYP;
ind = e.ind; % table de connectivite

Ie = 0;
for k=1:NPI
    Qk =0;
    for ie = 1:NBN
        iglobal = ind(ie); % passage local -> global
        Qie = fem.sol(iglobal); % iglobal in [1, fem.NP]
        Qk = Qk + Qie * alpha(ie, k);
    end
    Ie = Ie + Qk * detJ(k) * pds(k);
end

end










