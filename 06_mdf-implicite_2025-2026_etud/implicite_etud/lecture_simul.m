function [simul]=lecture_simul(phys)

%=======================================================================
%			recuperation des saisies - zones de saisies utilisateur
%=======================================================================
%
%  PARAMETRES DE LA SIMULATION et 
%  TEST SUR LA STABILITE SPATIALE
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
%  simul.vitesse  : Vitesse du barreau

prompt = {'longueur du barreau','Pas d''espace','Duree de la simulation','Pas de temps','Temperature initiale','Vitesse'};
dlg_title = 'Parametres de la simulation';
num_lines= 1;
def     = {'1','0.005','60','1','300','0'};
valeur  = inputdlg(prompt,dlg_title,num_lines,def);
simul.longueur = str2double(valeur(1));
simul.deltax = str2double(valeur(2));
simul.tfinal = str2double(valeur(3));
simul.deltat = str2double(valeur(4));
simul.Tinit = str2double(valeur(5));
simul.vitesse = str2double(valeur(6));

%
%  INFORMATIONS SUR LA STABILITE
%
%  1 -- > stabilite spatiale 
if simul.vitesse ~= 0
    deltax_max=2*phys.kth/(phys.rho*phys.cp*simul.vitesse);
    if simul.deltax > deltax_max
         %ATTENTION('SCHEMA SPATIAL INSTABLE')
          message=strcat('SCHEMA SPATIAL INSTABLE : deltax > ',num2str(deltax_max));
          questdlg(message,'!! Attention !!','OK','OK');
    end
end
 
 