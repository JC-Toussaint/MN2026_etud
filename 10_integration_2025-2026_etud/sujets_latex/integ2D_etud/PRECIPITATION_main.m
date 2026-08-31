% INTEGRATION NUMERIQUE - METHODE DE GAUSS - INTERPOLATION PAR
% POLYNOMES DE LAGRANGE - ORDRE 1 SUR TRIANGLE
% 1 OU 3 POINTS D INTEGRATION SUR TRIANGLE
% PROGRAMME DE CALCUL DE LA HAUTEUR MOYENNE DE PRECIPITATION
%

clear all;
close all;
clc

% nom : nom du fichier contenant le maillage et la solution aux noeuds
nom='triangles.pro';                 

% lecture maillage + valeurs aux noeuds
[fem, err]=lecture_probleme(nom);

% affichage maillage avec numerotation des noeuds et des elements
affichage_maillage(fem);

% calcul de l'integrale
I=solution(fem);

% affichage
disp(['Integrale : ' num2str(I)]);

 
 
