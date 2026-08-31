function analytique(phys,simul,x,yi)
%
%    Solution analytique de l EDP dans l ailette en regime permanent
%    
%    Entree :
%    phys  : contient les caractéristiques physiques du domaine,
%            propriétés physiques et conditions aux limites
%
%    simul : contient la description de la géométrie, les caractéristiques
%            temporelles , la température initiale et la vitesse
% Coefficient d''echange convectif, Temperature ambiante
h  = phys.hc;    % Coeffcicient d echange lateral
Ta  = phys.Ta;  % Temperature laterale
T0= phys.Tdg; % Temperature de Dirichlet a gauche
L = simul.longueur; % Longueur de l ailette
e= simul.epais; % epaisseur de l ailette
k = phys.kth; % Conductivite thermique de l ailette

% Variable intermediaire
r=sqrt(2*h/(k*e));

Trp=(T0-Ta)*cosh(r*(x-L))/cosh(r*L)+Ta;

% Extraction de la solution au dernier pas de calcul
nummax=round(simul.tfinal/simul.deltat+1);
Trp_num=yi(:,nummax);

figure(2)
hold on
plot(x,Trp,'b-+','LineWidth',2)
plot(x,Trp_num,'r-+','LineWidth',2)
titre=strcat('Resolution d''EDP en regime permanent - Solution analytique et numerique ');
legend('Analytique','Numerique')
title(titre)
xlabel('Position')
ylabel('Temperature')
grid on

