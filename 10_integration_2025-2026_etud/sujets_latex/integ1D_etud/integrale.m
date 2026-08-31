function [Ie]=integrale(fem,ne)
% Calcul de l integrale de la fonction Ie sur l'element ne
% fem : structure elements finis
% ne : numero de l element

Ie = 0.;

% chargement des polynomes de Lagrange pour le segment a 2 noeuds
% du determinant jacobien et du poids associes a chaque point
% de Gauss
[gauss]=polynomes_L2(fem,ne);
 
NPI=gauss.NPI;
NBN=fem.elt(ne).NBN;

% calcul de l integrale sur 1'element
% A COMPLETER
