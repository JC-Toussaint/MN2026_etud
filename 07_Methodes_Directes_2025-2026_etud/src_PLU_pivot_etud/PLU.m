function [P, L, U]=PLU(A)
% factorisation PLU d'une matrice A
% A=P*L*U

n=size(A, 1); % nb de lignes de A
In=eye(n , n);
PL=In;
P =In;

for k=1:n-1
    Pk=In;
    i=find_pivot(A, k);

% echange des lignes i et k      
    Pk([i, k], :)=Pk([k, i], :);
    A ([i, k], :)=A ([k, i], :);

% A COMPLETER    

end

U=A;
invP=P';
L=invP*PL;
end

function idx=find_pivot(A, k)
% A COMPLETER

end
