function [simul]=lecture_simul(phys)

%=======================================================================
%			recuperation des saisies - zones de saisies utilisateur
%=======================================================================
%
%  PARAMETRES DE LA SIMULATION et 
%  TESTS SUR LA STABILITE SPATIALE ET TEMPORELLE
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
%  simul.Vitesse  : Vitesse du barreau

prompt = {'Epaisseur du mur / dalle','Pas d''espace','Duree de la simulation','Pas de temps','Temperature initiale'};
dlg_title = 'Parametres de la simulation';
num_lines= 1;
def     = {'0.2','0.005','18000','10','273'};
valeur  = inputdlg(prompt,dlg_title,num_lines,def);
simul.longueur = str2double(valeur(1));
simul.deltax = str2double(valeur(2));
simul.tfinal = str2double(valeur(3));
simul.deltat = str2double(valeur(4));
simul.Tinit = str2double(valeur(5));

%
%  INFORMATIONS SUR LA STABILITE TEMPORELLE
%
deltat_max=(phys.rho*phys.cp/(2*phys.kth))*(simul.deltax^2);
(phys.rho*phys.cp/(2*phys.kth))
simul.deltat/(simul.deltax^2)

 if simul.deltat > deltat_max
         %ATTENTION('SCHEMA TEMPOREL EXPLICITE INSTABLE')
          message=strcat('SCHEMA TEMPOREL EXPLICITE INSTABLE : deltat > ',num2str(deltat_max));
          questdlg(message,'!! Attention !!','OK','OK');
 end

 
 