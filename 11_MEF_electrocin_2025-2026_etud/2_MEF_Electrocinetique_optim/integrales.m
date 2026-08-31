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
        nrg=e.NRG; %numero de region de l'element lineique
        jn=fem.equ.jn(nrg);
        
        NPI=gauss.NPI;
        pds=gauss.pds;
        detJ=gauss.detJ;
        
        for npi=1:NPI
            for ie=1:NBN
                alphai = gauss.alpha(ie, npi);
                
                % EXPRESSIONS INTEGRALES VECTORIELLES
                BE(ie) =  BE(ie) + jn * alphai * pds(npi)*detJ(npi);
                
            end
        end
        
    case 2 % cas surfacique
        % chargement des polynomes de Lagrange pour triangle a 3 noeuds
        [gauss]=polynomes_T3(fem, ne);
        
        nrg=e.NRG; %numero de region de l'element surfacique
        sigma=fem.equ.sigma(nrg);
        
        NPI=gauss.NPI;
        pds=gauss.pds;
        detJ=gauss.detJ;
        
        for npi=1:NPI
            for ie=1:NBN
                alphai = gauss.alpha(ie, npi);
                dalphai_dx = gauss.dalpha_dx(ie, npi);
                dalphai_dy = gauss.dalpha_dy(ie, npi);
                
                for je=1:NBN
                    alphaj = gauss.alpha(je, npi);
                    dalphaj_dx = gauss.dalpha_dx(je, npi);
                    dalphaj_dy = gauss.dalpha_dy(je, npi);
                    
                    %EXPRESSIONS INTEGRALES MATRICIELLES
                    gradai_gradaj=dalphai_dx*dalphaj_dx+dalphai_dy*dalphaj_dy;
                    AE(ie,je) = AE(ie,je) + sigma*gradai_gradaj * pds(npi)*detJ(npi);
                end
            end
        end
end
end


