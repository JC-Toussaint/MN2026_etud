% [AE,BE]= integrales(fem, ne) 
% Calcul des matrices elementaires AE et BE
% Entree/
% structure fem et le numero ne de l'element triangulaire a traiter
% Sortie/
% matrices elementaires AE et BE

function [AE,BE]= integrales(fem, ne)  
% fem.elt(ne) : element en cours de traitement
% recuperer les poids et abscisses en fonction du type d elements
% polynomes de Lagrange associes a ses noeuds ainsi que leurs
% gradients

% traitement de l'element e=fem.elt(ne)
e=fem.elt(ne);
NBN=e.NBN;

AE=zeros(NBN,NBN);
BE=zeros(NBN);

switch (e.TYP)
       case 1 % cas lineique
                % chargement des polynomes de Lagrange pour segment a 2 noeuds 
                [gauss]=polynomes_S2(fem, ne);
                nrg=e.NRG; %numero de region de l'element
                
                NPI=gauss.NPI;
                pds=gauss.pds;
                detJ=gauss.detJ;

%%% DEBUT DU BLOC A RECOPIER DANS VOTRE COPIE %%%    
%%% FIN DU BLOC A RECOPIER DANS VOTRE COPIE
                    
       case 2 % cas surfacique
                % chargement des polynomes de Lagrange pour triangle a 3 noeuds
                [gauss]=polynomes_T3(fem, ne);

                nrg=e.NRG; %numero de region de l'element
                eta =fem.equ.eta(nrg);
                rho =fem.equ.rho(nrg);
                fz0 =fem.equ.fz0(nrg);  
                freq=fem.equ.freq(nrg);  
                
                omega=2*pi*freq;
                
                NPI=gauss.NPI;
                pds=gauss.pds;
                detJ=gauss.detJ;

%%% DEBUT DU BLOC A RECOPIER DANS VOTRE COPIE %%%    
                 
%%% FIN DU BLOC A RECOPIER DANS VOTRE COPIE
      end;


