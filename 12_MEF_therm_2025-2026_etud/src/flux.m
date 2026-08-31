% flux a travers toutes les parois
function [qn]= flux(fem)

%initialisation obligatoire du flux qn
qn =0;

NE=fem.NE;
for ne=1:NE
    e=fem.elt(ne);
    if e.TYP==1 % segment
        NBN=e.NBN;
        
        [gauss]=polynomes_S2(fem, ne);
        nrg=e.NRG; %numero de region de l'element
        hcv =fem.equ.hcv(nrg);
        Ta  =fem.equ.Ta (nrg);
        
        NPI  =gauss.NPI;
        pds  =gauss.pds;  % pds(k)
        detJ =gauss.detJ; % detJ(k)
        alpha=gauss.alpha;% alpha(ie, k)
        
        for k=1:NPI
            % interpolation de T au point k
            Tk=0;
            for je=1:NBN
                jglobal = e.ind(je);
                Tje = fem.sol(jglobal);
                Tk = Tk + alpha(je, k) * Tje;
            end
            
            qn = qn + detJ(k)*pds(k)*hcv*(Tk-Ta);
        end % k
        
    end % segments
    
end % ne

end
