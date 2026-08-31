% SEANCE 3 : METHODE DES DIFFERENCES FINIES - ORDRE 2 - IMPLICITE - LINEAIRE
%            UN SEUL DOMAINE D'ETUDE EN DIMENSION 1
%            EQUATION THERMIQUE TRANSITOIRE AVEC DIFFUSION, SOURCE ET 
%            NEUMANN OU DIRICHLET EN FRONTIERE
%
%  Le programme comporte 2 structures de données :
%
%  La structure phys 
%  -----------------
%  Cette structure contient toutes les données physiques du domaine d'étude
%
%  phys.kth     : Conductivité thermique du matériau
%  phys.rho     : Masse volumique du matériau
%  phys.cp      : Capacité calorifique du matériau
%
%  phys.type_cl_gauche : Type de condition aux limites à gauche 
%                        (DIRICHLET ou NEUMAN)
%  phys.type_cl_droite : Type de condition aux limites à droite 
%                        (DIRICHLET ou NEUMAN)
%  phys.Tdg     : Température de DIRICHLET à gauche
%  phys.Tdd     : Température de DIRICHLET à droite
%  phys.Tag     : Température ambiante à gauche
%  phys.Tad     : Température ambiante à droite
%  phys.hg      : Coefficient d'échange convectif à gauche
%  phys.hd      : Coefficient d'échange convectif à droite
%
%  La structure simul
%  ------------------
%  Cette structure contient les caractéristiques géométriques ainsi que 
%  les paramètres temporels de la simulation, la température initiale et
%  la vitesse si il y a lieu.
%  
%  simul.longueur : Longueur du barreau
%  simul.deltax   : Pas d'espace
%  simul.tfinal   : Durée totale de la simulation
%  simul.deltat   : Pas de temps
%  simul.Tinit    : Température initiale du barreau
%
%
%  Noms des fonctions :
%  
%  MDFI_main            : Programme principal
%    lecture_probleme   : Lecture des proprietes physiques
%    lecture_simul      : Lecture des parametres de la simulation
%    implicite          : Algorithme de résolution transitoire implicite
%      source           : Fonction permettant de calculer la source en un point
%                       défini par sa coordonnée sur le barreau
%      tridiag          : Resolution du systeme tridiagonal
%    affichage_solution :
%      val_coul         : Fonction permettant d'associer une couleur en fonction
%                         d'un index de manière à colorier les courbes résultats 
%                         en fonction du temps.
%

%
%  PROPRIETES PHYSIQUES DU MATERIAU et CONDITIONS AUX LIMITES A GAUCHE
%
[phys]=lecture_probleme

%
%  PARAMETRES DE LA SIMULATION
%
% Parametres de la simulation et tests sur la stabilite
[simul]=lecture_simul(phys)
 
% methode implicite
[x,Tn]=implicite(phys,simul);

%
%  AFFICHAGE DU RESULTAT
%
% Representation graphique              
affichage_solution(x,Tn,simul)
