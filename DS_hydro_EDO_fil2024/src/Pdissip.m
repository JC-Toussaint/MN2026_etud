% puissance dissipee
% Puis = Pdissip(fem)  

function [Puis]= Pdissip(fem)  
Puis =0;
 
NE=fem.NE;
for ne=1:NE
    e=fem.elt(ne);
    NBN=e.NBN;
    
    switch (e.TYP)
       case 1 % cas lineique
                % chargement des polynomes de Lagrange pour segment a 2 noeuds 
                [gauss]=polynomes_S2(fem, ne);
                nrg=e.NRG; %numero de region de l'element
               
                NPI=gauss.NPI;
                pds=gauss.pds;
                detJ=gauss.detJ;
                
                   
       case 2 % cas surfacique
                % chargement des polynomes de Lagrange pour triangle a 3 noeuds
                [gauss]=polynomes_T3(fem, ne);
                nrg=e.NRG; %numero de region de l'element
                eta =fem.equ.eta(nrg);

                NPI=gauss.NPI;
                pds=gauss.pds;
                detJ=gauss.detJ;

%%% DEBUT DU BLOC A RECOPIER DANS VOTRE COPIE %%%           

%%% FIN DU BLOC A RECOPIER DANS VOTRE COPIE
                                 
    end;
end;

