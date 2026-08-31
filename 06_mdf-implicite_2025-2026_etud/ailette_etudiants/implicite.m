function [x,Tn]=implicite(phys,simul)

% Programme de resolution d EDP 
% par la mehode des differences finis
% implicite transitoire

%   phys  : contient les caracteristiques physiques du domaine,
%           proprietes physiques et conditions aux limites
%
%   simul : contient la description de la geometrie, les caracteristiques
%           temporelles , la temperature initiale et la vitesse
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

% Nombre total de pas de temps
nt=round(tfinal/deltat+1);
Tn=zeros(N,nt);

% declaration du systeme creux
A =sparse(N,N); % matrice du 1er membre
b =zeros(N,1);  % vecteur du 2nd membre

% allocations et initialisations a zero
T=zeros(N,1);
Tprec = zeros(N,1);    % valeurs aux noeuds de l'inconnu a l'instant n
Tprec(:)=simul.Tinit;

x=[0:N-1]*deltax;      % abscisses reelles des noeuds

% nombre de pas de temps
nt=round(tfinal/deltat+1);
Tn=zeros(N,nt);

% Boucle sur le temps
inc=1;

for t=0:deltat:tfinal
   
	% Initialisation : CAL a gauche
	if phys.type_cl_gauche=='DIRICHLET'		
        % CAL de Dirichlet
        x(1)=0;
		A(1, 1)=1;
		b(1)=phys.Tdg;
    else
        % CAL de Neumann
        x(1)=0;
	end

	% Points interieurs du maillage
	for p=2:N-1
        % schema centre
        x(p)=(p-1)*deltax;

	end

	% Initialisation : CAL a droite
	if phys.type_cl_droite=='DIRICHLET'  
        % CAL de Dirichlet
   	    x(N)=(N-1)*deltax;
	    A(N, N)=1;
        
   	    b(N)=phys.Tdd;
    else
        % CAL de Neumann
        x(N)=(N-1)*deltax;
        
	end

	%Resolution du systeme [A][y]=[b]

	T=A\b;
	% stockage des differents pas de temps
	Tprec(:)=T(:);
    Tn(:,inc)=T(:);
	inc=inc+1;
end

