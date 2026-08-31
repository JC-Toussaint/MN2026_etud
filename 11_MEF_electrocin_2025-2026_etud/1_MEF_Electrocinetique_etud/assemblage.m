% [A,B]=assemblage(fem ,ne, AE, BE, A, B) 
% Accumulation des matrices elementaires AE et BE dans les
% matrices globales A et B
% Entree/
% structure fem et ne numero de l'element a traiter
% AE et BE matrices elementaires associees a l'element ne
% Entree et Sortie
% A et B matrices globales

function [A,B]=assemblage(fem ,ne, AE, BE, A, B)  

% traitement de l'element e=fem.elt(ne)
e=fem.elt(ne);
NBN=e.NBN;

% A COMPLETER
for ie=1:NBN
    i = e.ind(ie); % passage de local -> global
    B(i) = B(i) + BE(ie);
    
    for je=1:NBN
        j = e.ind(je); % passage de local -> global       
        A(i, j) = A(i, j) + AE(ie, je);
    end
end

end




