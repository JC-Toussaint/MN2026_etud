function [phys]=lecture_probleme

%=======================================================================
%			recuperation des saisies - zones de saisies utilisateur
%=======================================================================
%
%  PROPRIETES PHYSIQUES DU MATERIAU et CONDITIONS AUX LIMITES A GAUCHE
%
%
%  La structure phys 
%  -----------------
%  Cette structure contient toutes les donnees physiques du domaine d'etude
%
%  phys.kth     : Conductivite thermique du materiau
%  phys.rho     : Masse volumique du materiau
%  phys.cp      : Capacite calorifique du materiau

% AJOUT DE hc et Ta POUR LE PROBLEME DE L'AILETTE
%  phys.hc      : Coefficient d'echange convectif
%  phys.Ta      : Temperature ambiante
%
%  phys.type_cl_gauche : Type de condition aux limites a gauche 
%                        (DIRICHLET ou NEUMAN)
%  phys.type_cl_droite : Type de condition aux limites a droite 
%                        (DIRICHLET ou NEUMAN)
%  phys.Tdg     : Temperature de DIRICHLET a gauche
%  phys.Tdd     : Temperature de DIRICHLET a droite
%

% AJOUT DE 'Coefficient d''echange convectif', 'Temperature ambiante'
% POUR LE PROBLEME DE L'AILETTE
prompt = {'Conductivite thermique','Masse volumique','Capacite calorifique', ...
    'Coefficient d''echange convectif', 'Temperature ambiante'};
dlg_title = 'Proprietes physiques ';
num_lines= 1;
def     = {'237','2700','897', '200', '300'};
valeur  = inputdlg(prompt,dlg_title,num_lines,def);
phys.kth = str2double(valeur(1));
phys.rho = str2double(valeur(2));
phys.cp = str2double(valeur(3));
phys.hc = str2double(valeur(4));
phys.Ta = str2double(valeur(5));

%
%  CONDITIONS AUX LIMITES A GAUCHE
%

%questdlg('Conditions aux limites a gauche','CAL','OK','OK');
v = 0;
while v == 0
    [rg,v] = listdlg('PromptString','Conditions aux limites a gauche : Dirichlet ou Neumann ?',...
                     'SelectionMode','single',...
                     'ListString',{'NEUMANN','DIRICHLET'},...
                     'InitialValue',2,...
                     'listSize',[400 80],...
                     'Name','Type de Conditions aux limites');
end

% Dirichlet rg=2
if rg==2
   prompt = {'Temperature de Dirichlet'};
   dlg_title = 'Conditions de Dirichlet a gauche';
   num_lines= 1;
   def     = {'500'};
   valeur  = inputdlg(prompt,dlg_title,num_lines,def);
   phys.Tdg = str2double(valeur);
   % Type de CAL a gauche / a droite
   % 1 : Dirichlet / 0 : Neumann
   phys.type_cl_gauche='DIRICHLET';
%   dirg=1;
% Neumann rg=1
elseif rg==1
   phys.type_cl_gauche='NEUMAN   ';
end

%
%  CONDITIONS AUX LIMITES A DROITE
%

%questdlg('Conditions aux limites a droite','CAL','OK','OK');
v = 0;
while v ==0
    [rd,v] = listdlg('PromptString','Conditions aux limites a droite : Dirichlet ou Neumann ?',...
                     'SelectionMode','single',...
                     'ListString',{'NEUMANN','DIRICHLET'},...
                     'InitialValue',2,...
                     'listSize',[400 80],...
                     'Name','Type de CAL');
end
% Dirichlet rd=2
if rd==2
   prompt = {'Temperature de Dirichlet'};
   dlg_title = 'Conditions de Dirichlet a droite';
   num_lines= 1;
   def     = {'300'};
   valeur  = inputdlg(prompt,dlg_title,num_lines,def);
   phys.Tdd = str2double(valeur);
   % Type de CAL a gauche / a droite
   % 1 : Dirichlet / 0 : Neumann
%   dird=1;
   phys.type_cl_droite='DIRICHLET';
% Neumann rd=1
elseif rd==1
   phys.type_cl_droite='NEUMAN   ';
end
