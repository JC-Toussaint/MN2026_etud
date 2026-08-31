%  METHODE DES DIFFERENCES FINIES - ORDRE 2 - EXPLICITE - LINEAIRE
%  UN SEUL DOMAINE D'ETUDE EN DIMENSION 1
%  EQUATION THERMIQUE TRANSITOIRE AVEC DIFFUSION, SOURCE ET 
%  NEUMAN OU DIRICHLET EN FRONTIERE
%
%  Le programme comporte 2 structures de donnees :
%
%  La structure phys 
%  -----------------
%  Cette structure contient toutes les donnees physiques du domaine d'etude
%
%  phys.kth     : Conductivite thermique du materiau
%  phys.rho     : Masse volumique du materiau
%  phys.cp      : Capacite calorifique du materiau
%
%  phys.type_cl_gauche : Type de condition aux limites a gauche 
%                        (DIRICHLET ou NEUMAN)
%  phys.type_cl_droite : Type de condition aux limites a droite 
%                        (DIRICHLET ou NEUMAN)
%  phys.Tdg     : Temperature de DIRICHLET a gauche
%  phys.Tdd     : Temperature de DIRICHLET a droite
%  phys.Tag     : Temperature ambiante a gauche
%  phys.Tad     : Temperature ambiante a droite
%  phys.hg      : Coefficient d'echange convectif a gauche
%  phys.hd      : Coefficient d'echange convectif a droite
%
%  La structure simul
%  ------------------
%  Cette structure contient les caracteristiques geometriques ainsi que 
%  les parametres temporels de la simulation, la temperature initiale et
%  la vitesse si il y a lieu.
%  
%  simul.longueur : Longueur du barreau
%  simul.deltax   : Pas d'espace
%  simul.tfinal   : Duree totale de la simulation
%  simul.deltat   : Pas de temps
%  simul.Tinit    : Temperature initiale du barreau
%
%  Noms des fonctions :
%  
%  MDFE_main  : Programme principal
%    lecture_probleme : Lecture des proprietes physiques
%    lecture_simul        : Lecture des parametres de la simulation
%    explicite                 : Algorithme de resolution transitoire explicite
%      source      : Fonction permettant de calculer la source en un point
%                         defini par sa coordonnee sur le barreau
%    affichage_solution : affichage graphique de la solution
%      rgb           : Fonction permettant d'associer une couleur en fonction
%                         d'un index de maniere a colorier les courbes resultats 
%                         en fonction du temps.

%
%  PROPRIETES PHYSIQUES DU MATERIAU et CONDITIONS AUX LIMITES
%
[phys]=lecture_probleme;
%
%  PARAMETRES DE LA SIMULATION
%
% Parametres de la simulation et tests sur la stabilite
[simul]=lecture_simul(phys);
 %
%   RESOLUTION TRANSITOIRE DU PROBLEME
% 
[x,Tn]=explicite(phys, simul);
%
%  AFFICHAGE DU RESULTAT
%
% Representation graphique              
affichage_solution(x, Tn, simul);


