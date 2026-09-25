function [x,Tn]=implicite(phys,simul)

% Programme de resolution d EDP 
% par la mehode des differences finis
% implicite transitoire

%   phys  : contient les caractéristiques physiques du domaine,
%           propriétés physiques et conditions aux limites
%
%   simul : contient la description de la géométrie, les caractéristiques
%           temporelles , la température initiale et la vitesse
%

% parametres materiaux
kth = phys.kth;
rho = phys.rho;
cp  = phys.cp;

% parametres simuls
longueur = simul.longueur;
deltax   = simul.deltax;
deltat   = simul.deltat;
tfinal   = simul.tfinal;

% Nombre total de noeuds
NP=round(longueur/deltax+1);

% allocations et initialisations a zero
Tprec = zeros(NP,1);
T     = zeros(NP,1);
x     = zeros(NP,1);

x=[0:NP-1]*deltax;

Tprec(:)=simul.Tinit;

%sauvegarde du vecteur colonne Tprec(:) 
%dans la 1ere colonne de la matrice Tn
Tn = Tprec(:);

% Boucle sur le temps
t=0;
while t<tfinal
   
	% Initialisation : CAL a gauche
	if phys.type_cl_gauche=='DIRICHLET'		
        % CAL de Dirichlet
        x(1)=0;
		A(1, 1)=1;
		b(1)=phys.Tdg;
    else
        % CAL de Neumann
        hg  = phys.hg;
        Tag = phys.Tag;
        %%% DEBUT DU BLOC A RECOPIER DANS VOTRE COPIE %%%
        % A COMPLETER
        %%% FIN DU BLOC A RECOPIER DANS VOTRE COPIE %%%        
	end

	% Points interieurs du maillage
	for p=2:NP-1
        %%% DEBUT DU BLOC A RECOPIER DANS VOTRE COPIE %%%
        % A COMPLETER
        %%% FIN DU BLOC A RECOPIER DANS VOTRE COPIE %%%
	end

	% Initialisation : CAL a droite
	if phys.type_cl_droite=='DIRICHLET'  
        % CAL de Dirichlet
   	    x(NP)=(NP-1)*deltax;
		A(NP, NP)=1;
        
   	    b(NP)=phys.Tdd;
    else
        % CAL de Neumann
        %%% DEBUT DU BLOC A RECOPIER DANS VOTRE COPIE %%%
        % A COMPLETER
        %%% FIN DU BLOC A RECOPIER DANS VOTRE COPIE %%%
	end

	%Resolution du systeme [A][T]=[b]
	T=A\b;
    
	% stockage des differents pas de temps
    t = t+deltat;
    Tprec(:) = T(:); % (:) notation pas necessaire
    Tn = [Tn T(:)];  % ajout a droite du vecteur colonne T
end

