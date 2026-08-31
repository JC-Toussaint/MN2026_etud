% METHODE DES ELEMENTS FINIS
% INTERPOLATION PAR POLYNOMES DE LAGRANGE - ORDRE 1 
% METHODE D'INTEGRATION DE GAUSS : 
% 2 POINTS SUR SEGMENT, 3 POINTS D INTEGRATION SUR TRIANGLES
%
%Les deux structures de données du programme :	
%fem et gauss	
%
%La structure fem
%----------------
%fem.noeud(i).x	: abscisse du noeud numero i (numerotation globale)
%fem.noeud(i).y	: ordonnée du noeud numero i (numerotation globale)
%
%ne	: numero de l element selectionne
%HYP : apres affectation de la ne_ieme valeur du tableau fem.elt dans la variable e
%e=fem.elt(ne) contient toutes les informations sur l'element ne 
%
%fem.elt(ne).TYP ou e.TYP : type de l element ne (1 : lineique, 2 : surfacique)
%fem.elt(ne).NBN ou e.NBN : nombre de noeuds de l'élément ne
%fem.elt(ne).NRG ou e.NRG : numéro de region de l'élément ne
%fem.elt(ne).ind(ie)ou e.ind(ie): numéro de noeud global du noeud local ie dans l element ne
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
%gauss.NPI	: nombre de points d intégration
%gauss.pds(npi)	: poids du point de gauss npi
%gauss.alpha(ie,npi) : polynome du noeud ie au point de gauss npi
%gauss.dalpha_dx(ie,npi) : derivee /à x du polynome du noeud ie au point de gauss npi
%gauss.dalpha_dy(ie,npi) : derivee /à y du polynome du noeud ie au point de gauss npi
%gauss.detJ(npi) : déterminant de la matrice Jacobienne au point d'intégration npi
%
%ne	: Numero de l element selectionne
%
%Nom des fonctions
%-----------------
%MEF_main                   Programme principal
%	lecture_probleme		Lecture des données du problème
%	affichage_maillage		Affichage du maillage et de la numérotation des nœuds et des éléments
%	solution				Calcul de la solution aux noeuds du maillage
%		integrale			Calcul des éléments de la matrice éléments finis
%           polynomes_S2		Dans un segment à 2 nœuds : Poids et coordonnées de Gauss / Polynomes et dérivées des polynomes au k point d'intégration et au n nœud
%           polynomes_T3		Dans un triangle à 3 nœuds : Poids et coordonnées de Gauss / Polynomes et dérivées des polynomes au k point d'intégration et au n nœud
%       assemblage : on assemble et on tient compte des conditions aux limites
%       conditions : prise en compte des conditions aux limites de dirichlet
%	affichage_solution		Affichage des résultats
%   pick : calcul de l inconnue et du gradient de l inconnue en un point (x0,y0)
%           ai_gradai_T3 : Dans un triangle à 3 nœuds : Polynomes et dérivées des polynomes
%   profil : calcul de l inconnue et du gradient de l inconnue sur un segment
%           pick : calcul de l inconnue et du gradient de l inconnue en un point (x0,y0)
%               ai_gradai_T3 : Dans un triangle à 3 nœuds : Polynomes et dérivées des polynomes

clear all;
close all;

% liste de tous les fichiers de maillage
files=dir('*.pro');
text={files(:).name}; % stockage dans un tableau

% choix dans une liste
[rg, ok] = listdlg('PromptString','choisir un maillage',...
                   'SelectionMode','single',...
                   'ListString', text,...
                   'listSize',[400 80]);
% nom du maillage selectionne
nom=files(rg).name;                 

% lecture maillage + affectations par regions
[fem, err]=lecture_probleme(nom);

if (err == 0)    
    % affichage maillage avec numerotation des noeuds et des elements
    affichage_maillage(fem);

    % calcul de la solution de l'equation de la chaleur
    fem = solution(fem);

    % affichage de la solution
    affichage_solution(fem);
    x0=0.5;
    y0=0.5;
    [val,grad_val_x,grad_val_y, err]=pick(fem, x0, y0)

    Npts=100;
    profil(fem, Npts, 0, 0.5, 1, 0.5);
else
    % si erreur a l ouverture du fichier
	message=strcat('Probleme d ouvertue du fichier :',nomfich);
    warndlg(message,'!! Warning !!')
end
