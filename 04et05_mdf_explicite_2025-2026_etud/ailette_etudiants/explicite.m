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
N=round(longueur/deltax+1);

% allocations et initialisations a zero
Tprec = zeros(N,1);    % valeurs aux noeuds de l'inconnu a l'instant n
T     = zeros(N,1);    % valeurs aux noeuds de l'inconnu a l'instant n+1
x=[0:N-1]*deltax;      % abscisses reelles des noeuds

% Nombre total de pas de temps
nt=round(tfinal/deltat+1);
Tn=zeros(N,nt);

Tprec(:)=simul.Tinit;

% Boucle sur le temps
inc=1;
for t=0:deltat:tfinal
   
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
   for p=2:N-1
        % A COMPLETER
   end

	% Initialisation : CAL a droite
	if phys.type_cl_droite=='DIRICHLET'  
        % CAL de Dirichlet
        Tdd = phys.Tdd;
        x(N)=(N-1)*deltax;
        T(N)=Tdd;
    else
        % CAL de Neumann a droite       
        % A COMPLETER
    end

	% stockage des differents pas de temps
	Tprec(:)=T(:);
    Tn(:,inc)=T(:);
	inc=inc+1;
end

