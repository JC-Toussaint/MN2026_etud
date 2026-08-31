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
        jn=fem.equ.jn(nrg); % densite de courant
        
        NPI=gauss.NPI;
        pds=gauss.pds;		% pds(k)
        detJ=gauss.detJ;	% detJ(k)
        alpha=gauss.alpha; 	% alpha(ie, k)
        
        % A COMPLETER
        % PAS de contribution dans AE
        for ie=1:NBN
            % BE deja initialisé
            for k=1:NPI
                BE(ie) = BE(ie) -alpha(ie, k)*jn *detJ(k)*pds(k);
            end            
        end
            
        
    case 2 % cas surfacique
        % chargement des polynomes de Lagrange pour triangle a 3 noeuds
        [gauss]=polynomes_T3(fem, ne);
        
        nrg=e.NRG; %numero de region de l'element surfacique
        sigma=fem.equ.sigma(nrg); % conductivite electrique
        
        NPI=gauss.NPI;
        pds=gauss.pds;			% pds(k)
        detJ=gauss.detJ;		% detJ(k)
        alpha=gauss.alpha; 		% alpha(ie, k)
        dalpha_dx=gauss.dalpha_dx; 	% dalpha_dx(ie, k)
        dalpha_dy=gauss.dalpha_dy; 	% dalpha_dy(ie, k)
        
        % A COMPLETER
        % Pas de contribution dans BE
        for ie=1:NBN
            for je=1:NBN
                % AE deja initialisé
                for k=1:NPI
                    ggk = dalpha_dx(ie, k)*dalpha_dx(je, k) + ...
                          dalpha_dy(ie, k)*dalpha_dy(je, k);
                    AE(ie, je) = AE(ie, je) + ...
                        sigma * ggk *detJ(k) *pds(k);
                end % k in [1, NPI]
            end
        end
        
end

end













