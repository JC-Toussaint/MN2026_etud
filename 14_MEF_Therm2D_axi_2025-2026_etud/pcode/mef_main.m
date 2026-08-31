% SEANCE 5 : METHODE DES ELEMENTS FINIS
% INTERPOLATION PAR POLYNOMES DE LAGRANGE - ORDRE 1 
% METHODE D'INTEGRATION DE GAUSS : 
% 2 POINTS SUR SEGMENT, 3 POINTS D INTEGRATION SUR TRIANGLES
%
%Les deux structures de donnees du programme :	
%fem et gauss	
%
%La structure fem
%----------------
%fem.noeud(i).x	: abscisse du noeud numero i (numerotation globale)
%fem.noeud(i).y	: ordonnee du noeud numero i (numerotation globale)
%
%ne	: numero de l element selectionne
%HYP : apres affectation de la ne_ieme valeur du tableau fem.elt dans la variable e
%e=fem.elt(ne) contient toutes les informations sur l'element ne 
%
%fem.elt(ne).TYP ou e.TYP : type de l element ne (1 : lineique, 2 : surfacique)
%fem.elt(ne).NBN ou e.NBN : nombre de noeuds de l'element ne
%fem.elt(ne).NRG ou e.NRG : numero de region de l'element ne
%fem.elt(ne).ind(ie)ou e.ind(ie): numero de noeud global du noeud local ie dans l element ne
%
%Apres affectation e=fem.elt(ne) 
%fem.elt(ne).ind(ie) ou i=e.ind(ie): numero global i associe au noeud local ie 
%fem.noeud(i).x	: Abscisse du noeud local ie dans l element ne
%fem.noeud(i).y	: Ordonnee du noeud local ie dans l element ne
%
%fem.sol(i)	: Valeur de l'inconnue au noeud i (numerotation globale)
%
%La structure gauss
%------------------
%gauss.NPI	: nombre de points d integration
%gauss.pds(npi)	: poids du point de gauss npi
%gauss.alpha(ie,npi) : polynome du noeud ie au point de gauss npi
%gauss.dalpha_dx(ie,npi) : derivee /a x du polynome du noeud ie au point de gauss npi
%gauss.dalpha_dy(ie,npi) : derivee /a y du polynome du noeud ie au point de gauss npi
%gauss.detJ(npi) : determinant de la matrice Jacobienne au point d'integration npi
%
%ne	: Numero de l element selectionne
%
%Nom des fonctions
%-----------------
%MEF_main                   Programme principal
%	lecture_probleme		Lecture des donnees du probleme
%	affichage_maillage		Affichage du maillage et de la numerotation des neuds et des elements
%	solution				Calcul de la solution aux noeuds du maillage
%		integrale			Calcul des elements de la matrice elements finis
%           polynomes_S2		Dans un segment a 2 neuds : Poids et coordonnees de Gauss / Polynomes et derivees des polynomes au k point d'integration et au n neud
%           polynomes_T3		Dans un triangle a 3 neuds : Poids et coordonnees de Gauss / Polynomes et derivees des polynomes au k point d'integration et au n neud
%       assemblage : on assemble et on tient compte des conditions aux limites
%       conditions : prise en compte des conditions aux limites de dirichlet
%	affichage_solution		Affichage des resultats
%   pick : calcul de l inconnue et du gradient de l inconnue en un point (x0,y0)
%           ai_gradai_T3 : Dans un triangle e 3 neuds : Polynomes et derivees des polynomes
%   profil : calcul de l inconnue et du gradient de l inconnue sur un segment
%           pick : calcul de l inconnue et du gradient de l inconnue en un point (x0,y0)
%               ai_gradai_T3 : Dans un triangle e 3 neuds : Polynomes et derivees des polynomes
%opengl neverselect;

clear all;
close all;
clc

% liste de tous les fichiers de maillage
files=dir('*.pro');
text=char(files(:).name); % stockage dans un tableau

% choix dans une liste
[rg, ok] = listdlg('PromptString','choisir un maillage',...
                   'SelectionMode','single',...
                   'ListString',{text},...
                   'listSize',[400 80]);
% nom du maillage selectionne
nom=files(rg).name;                 

% lecture maillage + affectations par regions
[fem, err]=lecture_probleme(nom);

if (err == 0)  
    fem = femutil(fem);
    
    % affichage des regions 
    fem = affichage_region(fem);
    
    % affichage maillage 
    fem = affichage_maillage(fem);

    % calcul de la solution de l'equation de la chaleur
    fem = solution(fem);
    
    % affichage de la solution
    affichage_solution(fem);
    analytique(fem);

    Npts=200;
    profil(fem, Npts, fem.xmin, 0, fem.xmax, 0);
    
    %affichage_champ(fem);
    
else
    % si erreur a l ouverture du fic
end
