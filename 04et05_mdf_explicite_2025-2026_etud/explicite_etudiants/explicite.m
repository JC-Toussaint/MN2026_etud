function [x,Tn]=explicite(phys,simul)
%
%    Programme de resolution d EDP par la methode des differences finies
%    explicite transitoire
%    
%    Entrees :
%    phys  : contient les caracteristiques physiques du domaine,
%            proprietes physiques et conditions aux limites
%
%    simul : contient la description de la geometrie, les caracteristiques
%            temporelles , la temperature initiale et la vitesse
%
%    Sorties :
%    x       : abscisses des points d'echantillonnage
%    Tn       : valeurs de l'inconnue en chaque point et a chaque instant
% 
%    Variables intermediaires
%    Tprec   :  valeurs de l'inconnue en chaque point et a l instant n
%    T       :  valeurs de l'inconnue en chaque point et a l instant n+1

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
        hg  = phys.hg;
        Tag = phys.Tag;  
        
    % A COMPLETER
   end

   % Points interieurs du maillage
   for p=2:NP-1
       x(p)=(p-1)*deltax;

    % A COMPLETER    
       d2T_dx2 = (Tprec(p+1)+Tprec(p-1)-2*Tprec(p))/deltax^2;
       T(p) = Tprec(p) + kth/(rho*cp) * deltat * d2T_dx2;

   end

	% Initialisation : CAL a droite
	if phys.type_cl_droite=='DIRICHLET'  
        % CAL de Dirichlet
        Tdd = phys.Tdd;
        x(NP)=(NP-1)*deltax;
        T(NP)=Tdd;
    else
        % CAL de Neumann a droite
        hd  = phys.hd;
        Tad = phys.Tad;        
        dT_dx = -hd/kth*(Tprec(NP)-Tad);
        d2T_dx2 = 2/deltax^2 *(Tprec(NP-1)-Tprec(NP)+deltax*dT_dx);
        T(NP) = Tprec(NP) + kth/(rho*cp)*deltat * d2T_dx2;
          
    end

	% stockage des differents pas de temps
    t=t+deltat;
    Tprec(:) = T(:); % (:) notation pas necessaire
    Tn = [Tn T(:)];  % ajout a droite du vecteur colonne T
end

