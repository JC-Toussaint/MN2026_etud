function [x,Tn]=explicite(phys,simul)
%
%    Programme de resolution d EDP par la methode des differences finies
%    explicite transitoire
%    
%    Entree :
%    phys  : contient les caractéristiques physiques du domaine,
%            propriétés physiques et conditions aux limites
%
%    simul : contient la description de la géométrie, les caractéristiques
%            temporelles , la température initiale et la vitesse
%
%    Sortie :
%    x    : abscisses des points d'echantillonnage
%    Tn    : valeurs de l'inconnue en chaque point et a chaque instant
%   

% parametres materiaux
kth = phys.kth;
rho = phys.rho;
cp  = phys.cp;

% Coefficient d''echange convectif, Temperature ambiante
hc  = phys.hc;
Ta  = phys.Ta;

% parametres simuls
longueur = simul.longueur;
epais    = simul.epais;
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
Tn=Tprec(:);

% Boucle sur le temps
t=0;
while t<tfinal
   
	% Initialisation : CAL a gauche
	if phys.type_cl_gauche=='DIRICHLET'		
        % CAL de Dirichlet
        Tdg = phys.Tdg;
     	x(1) =0;
     	T(1)=Tdg;
	else				
        % CAL de Neumann a gauche
        % A COMPLETER
   end

   % Points interieurs du maillage
   for p=2:NP-1
        % A COMPLETER
   end

	% Initialisation : CAL a droite
	if phys.type_cl_droite=='DIRICHLET'  
        % CAL de Dirichlet
        Tdd = phys.Tdd;
        x(NP)=(NP-1)*deltax;
        T(NP)=Tdd;
    else
        % CAL de Neumann a droite       
        % A COMPLETER
    end

	% stockage des differents pas de temps
    t=t+deltat;
    Tprec(:) = T(:); % (:) notation pas necessaire
    Tn = [Tn T(:)];  % ajout a droite du vecteur colonne T
end

