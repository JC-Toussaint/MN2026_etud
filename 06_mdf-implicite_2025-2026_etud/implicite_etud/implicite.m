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

%changement de variable pour plus de lisibilite
longueur=simul.longueur;
deltax=simul.deltax;
deltat=simul.deltat;
tfinal=simul.tfinal;

N=round(longueur/deltax+1);

% Initialisation t=0
Tprec=zeros(N,1);
Tprec(:)=simul.Tinit;

% declaration du systeme creux
A =sparse(N,N); % matrice du 1er membre
b =zeros(N,1);  % vecteur du 2nd membre

T=zeros(N,1);
x=[0:N-1]*deltax;

% nombre de pas de temps
nt=round(tfinal/deltat+1);
Tn=zeros(N,nt);

% Boucle sur le temps
inc=1;

%changement de variable pour plus de lisibilite
kth = phys.kth; % conductivite thermique
rho = phys.rho; % masse volumique
cp = phys.cp;   % capacite calorifique

for t=0:deltat:tfinal
   
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
        
	end

	% Points interieurs du maillage
	for p=2:N-1
        A(p, p-1) =  -kth/deltax^2;
        A(p, p  ) = 2*kth/deltax^2 + rho*cp/deltat;
        A(p, p+1) =  -kth/deltax^2;
        b(p) = rho*cp/deltat * Tprec(p);
	end

	% Initialisation : CAL a droite
	if phys.type_cl_droite=='DIRICHLET'  
        % CAL de Dirichlet
   	    x(N)=(N-1)*deltax;
		A(N, N)=1;
        
   	    b(N)=phys.Tdd;
    else
        % CAL de Neumann
        % A COMPLETER
	end

	%Resolution du systeme [A][T]=[b]
	T=A\b;
    
	% stockage des differents pas de temps
	Tprec(:)=T(:);
    Tn(:,inc)=T(:);
	inc=inc+1;
end

