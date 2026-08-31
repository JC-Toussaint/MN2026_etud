% INTEGRATION NUMERIQUE - METHODE DE GAUSS - INTERPOLATION PAR
% POLYNOMES DE LAGRANGE - ORDRE 1 SUR TRIANGLE
% 1 OU 3 POINTS D INTEGRATION SUR TRIANGLE
% PROGRAMME DE CALCUL DE LA HAUTEUR MOYENNE DE PRECIPITATION
%
%Les 2 structures de donnees du programme :	
%fem et gauss	
%
%La structure fem
%----------------
%fem.NP : nombre de noeuds du maillage
%fem.noeud(np).x	: Abscisse du noeud numero np in [1, fem.NP]
%
%fem.NE : nombre total d'éléments finis
%fem.elt(ne).NBN : nombre de noeuds de l'element ne
%fem.elt(ne).ind(ie)	: Numero global du noeud local ie dans l'element ne
%fem.noeud(fem.elt(ne).ind(ie)).x	: Abscisse du noeud local ie dans l element ne
%fem.sol(np)	: Valeur de l inconnue au noeud np
%
%La structure gauss
%------------------
%gauss.NPI	: Nombre de points d integration
%gauss.u(k)	: Abscisse du point de gauss k in [1, NPI]
%gauss.pds(k)	: Poids du point de gauss k
%gauss.alpha(ie, k)	: Polynome du noeud ie in [1, NBN] au point de gauss k
%gauss.detJ(k)	: Determinant de la matrice Jacobienne au point de gauss k
%
%ne	: Numero de l element selectionne
%
%Nom des fonctions
%-----------------
%PRECIPITATION_main		Programme principal
%	lecture_probleme	Lecture des donnees du probleme
%	affichage_maillage	Affichage du maillage et de la numerotation des noeuds et des elements
%	solution		Calcul de l'integrale de la hauteur d'eau sur tous les elements 
%	integrale		Calcul de l'integrale elementaire sur l'element e
%   polynomes_T3    Dans un element a 3 noeuds : Poids et coordonnees de Gauss 
%                   Polynomes et derivees des polynomes au point k d'integration 
%                   et au noeud ie et calcul du determinant en chacun des points d'integration

clear all;
close all;
clc

% nom : nom du fichier contenant le maillage et les valeurs aux noeuds
nom='triangles.pro';                 

% lecture maillage + valeurs aux noeuds
[fem, err]=lecture_probleme(nom);

% affichage maillage avec numerotation des noeuds et des elements
affichage_maillage(fem);

% calcul de l'integrale
I=solution(fem);

% affichage
disp(['Integrale : ' num2str(I)]);

 
 
