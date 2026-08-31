% INTEGRATION NUMERIQUE - METHODE DE GAUSS - INTERPOLATION PAR
% POLYNOMES DE LAGRANGE - ORDRE 1 SUR SEGMENT
% 1 OU 2 POINTS D INTEGRATION SUR SEGMENT
% PROGRAMME DE CALCUL DE LA HAUTEUR MOYENNE DE PRECIPITATION
%
%Les 2 structures de donnees du programme :	
%fem et gauss	
%
%La structure fem
%----------------
%fem.noeud(n).x	: Abscisse du noeud numero n
%
%fem.elt(ne).ind(ie)	: Numero global du noeud local ie dans l'element ne
%
%fem.noeud(fem.elt(ne).ind(ie)).x	: Abscisse du noeud local ie dans l element ne
%
%fem.sol(n)	: Valeur de l inconnue au noeud n
%
%La structure gauss
%------------------
%gauss.NPI	: Nombre de points d integration
%gauss.u(k)	: Abscisse du kieme point de gauss 
%gauss.pds(k)	: Poids du kieme point de gauss 
%gauss.alpha(ie, k)	: Polynome du noeud ie au point de gauss k
%gauss.detJ(k)	 : Determinant de la matrice Jacobienne au point de gauss k
%
%ne	: Numero de l element selectionne
%
%Nom des fonctions
%-----------------
%PRECIPITATION_main		Programme principal
%	lecture_probleme	Lecture des donnees du probleme
%	affichage_maillage	Affichage du maillage et de la numerotation des noeuds et des elements
%	solution		Calcul de l'integrale de la hauteur d'eau sur tous les elements 
%	integrale		Calcul de la surface et de la precipitation sur l'element e
%       polynomes_L2		Dans un element a 2 noeuds : Poids et coordonnees de Gauss 
%                           	Polynomes et derivees des polynomes au k point d'integration 
%                           	et au n noeud et calcul du determinant en chacun des points d'integration

clear all;
close all;
clc

% nom : nom du fichier contenant le maillage et la solution aux noeuds
nom='mesh.pro';                 

% lecture maillage + valeurs aux noeuds
[fem, err]=lecture_probleme(nom);

% affichage maillage avec numerotation des noeuds et des elements
affichage_maillage(fem);

% calcul de l'integrale
I=solution(fem);

% affichage
disp(['Integrale : ' num2str(I)]);

 
 
