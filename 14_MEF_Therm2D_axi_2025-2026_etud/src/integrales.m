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
BE=zeros(NBN, 1);

switch (e.TYP)
       case 1 % cas lineique
                % chargement des polynomes de Lagrange pour segment a 2 noeuds 
                [gauss]=polynomes_S2(fem, ne);
                nrg=e.NRG; %numero de region de l'element
                hcv=fem.equ.hcv(nrg);
                Ta =fem.equ.Ta (nrg);
                
                NPI=gauss.NPI;
                pds=gauss.pds;
                detJ=gauss.detJ; % ATTENTION 2D cartesien
                x=gauss.x;	  
                y=gauss.y;
               
%%% DEBUT DU BLOC A RECOPIER DANS VOTRE COPIE %%%
% A COMPLETER
%%% FIN DU BLOC A RECOPIER DANS VOTRE COPIE %%%
                                   
       case 2 % cas surfacique
                % chargement des polynomes de Lagrange pour triangle a 3 noeuds
                [gauss]=polynomes_T3(fem, ne);

                nrg=e.NRG; %numero de region de l'element
                kth=fem.equ.kth(nrg);
                qth=fem.equ.qth(nrg);  

                NPI=gauss.NPI;
                pds=gauss.pds;
                detJ=gauss.detJ; % ATTENTION 2D cartesien
                x=gauss.x;
                y=gauss.y;
               
%%% DEBUT DU BLOC A RECOPIER DANS VOTRE COPIE %%%
% A COMPLETER
%%% FIN DU BLOC A RECOPIER DANS VOTRE COPIE %%%
                
      end;

end


      
      
      
      
      
      
      
      
