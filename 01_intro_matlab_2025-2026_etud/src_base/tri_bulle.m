function [A]=tri_bulle(A)
sz=length(A);
while true %------------ boucle infinie
    change = false;
    for i=1:sz-1
        if A(i+1)<A(i)
            tmp=A(i); A(i)=A(i+1); A(i+1)=tmp;
            change = true;
        end;
    end;
    if ~change % si aucun changement
        break; %--- sortie de boucle 
    end;
end;       %------------ fin de boucle
end

