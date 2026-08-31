% [AE,BE]= integrales(fem, ne)
% Calcul des matrices elementaires AE et BE
% Entree/
% structure fem et le numero ne de l'element triangulaire a traiter
% Sortie/
% matrice elementaire AE et vecteur elementaire BE

function [AE,BE]= integrales(fem, ne)
% fem.elt(ne) : element en cours de traitement
% recuperer les poids et abscisses en fonction du type d elements
% polynomes de Lagrange associes a ses noeuds ainsi que leurs
% gradients

% traitement de l'element e=fem.elt(ne)
e=fem.elt(ne);
NBN=e.NBN;

AE=zeros(NBN,NBN);
BE=zeros(NBN,  1);

switch (e.TYP)
    case 1 % cas lineique
        % chargement des polynomes de Lagrange
        % pour segment a 2 noeuds
        % gauss.NPI	: nombre de points d intégration
        % gauss.pds(k)	: poids du point de gauss k
        % gauss.alpha(ie, k) : polynome du noeud ie au point de
        % gauss k
        % gauss.detJ(k) : déterminant de la matrice Jacobienne
        % au point de gauss k
        
        [gauss]=polynomes_S2(fem, ne);
        nrg=e.NRG; %numero de region de l'element
        hcv =fem.equ.hcv(nrg);
        Ta  =fem.equ.Ta (nrg);
        
        NPI  =gauss.NPI;
        pds  =gauss.pds;  % pds(k)
        detJ =gauss.detJ; % detJ(k)
        alpha=gauss.alpha;% alpha(ie, k)
        
        %%% DEBUT DU BLOC A RECOPIER DANS VOTRE COPIE %%%
        for ie=1:NBN
            for je=1:NBN
                for k=1:NPI % accum
                    AE(ie, je) = AE(ie, je) + pds(k)*detJ(k) * ...
                        hcv * alpha(ie, k)*alpha(je, k);
                    
                end
            end
        end
        
        for ie=1:NBN
            for k=1:NPI
                BE(ie) = BE(ie) + pds(k)*detJ(k) * ...
                    hcv * alpha(ie, k)* Ta;
            end
        end
        
        %%% FIN DU BLOC A RECOPIER DANS VOTRE COPIE %%%
        
    case 2 % cas surfacique
        % chargement des polynomes de Lagrange
        % pour triangle a 3 noeuds
        % gauss.NPI	: nombre de points d intégration
        % gauss.pds(k)	: poids du point de gauss k
        % gauss.alpha(ie, k) : polynome du noeud ie au point de gauss k
        % gauss.dalpha_dx(ie, k) : derivee /à x du polynome du noeud ie au point de gauss k
        % gauss.dalpha_dy(ie, k) : derivee /à y du polynome du noeud ie au point de gauss k
        % gauss.detJ(k) : déterminant de la matrice Jacobienne au point d'intégration k
        
        [gauss]=polynomes_T3(fem, ne);
        
        nrg=e.NRG; %numero de region de l'element
        kth=fem.equ.kth(nrg);
        qth=fem.equ.qth(nrg);
        
        NPI=gauss.NPI;
        pds=gauss.pds;               % pds(k)
        detJ=gauss.detJ;             % detJ(k)
        alpha = gauss.alpha;         % alpha(ie, k)
        dalpha_dx = gauss.dalpha_dx; % dalpha_dx(ie, k)
        dalpha_dy = gauss.dalpha_dy; % dalpha_dy(ie, k)
        
        %%% DEBUT DU BLOC A RECOPIER DANS VOTRE COPIE %%%
        for ie=1:NBN
            for je=1:NBN
                for k=1:NPI % accum
                    ggk = dalpha_dx(ie, k)*dalpha_dx(je, k) + ...
                          dalpha_dy(ie, k)*dalpha_dy(je, k);
                    
                    AE(ie, je) = AE(ie, je) + pds(k)*detJ(k) * ...
                       kth * ggk;
                    
                end
            end
        end
                 
        for ie=1:NBN
            for k=1:NPI
                BE(ie) = BE(ie) + pds(k)*detJ(k) * ...
                    alpha(ie, k) * qth;
            end
        end
        %%% FIN DU BLOC A RECOPIER DANS VOTRE COPIE %%%
end

end

















