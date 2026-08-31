function [Ie]=integrale(fem,ne)

% Calcul de l integrale de la fonction (Ie) sur un element (ne)

% Fonction appellee
% -----------------
% polynomes_T3 :
% Calcul des polynomes sur element triangulaire
% et calcul du determinant du Jacobien

Ie  = 0.;

% ne : numero de l element
% recuperer les poids et abscisses en fonction du type d elements
% polynomes de Lagrange associes a ses noeuds ainsi que leurs
% gradients
    
% chargement des polynomes de Lagrange pour triangles a 3 noeuds
[gauss]=polynomes_T3(fem,ne);

NPI=gauss.NPI;
NBN=fem.elt(ne).NBN;
alpha=gauss.alpha;

/* A COMPLETER */

end
