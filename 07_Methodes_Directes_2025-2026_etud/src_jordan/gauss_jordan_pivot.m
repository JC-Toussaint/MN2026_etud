% Gauss_Jordan en Matlab / Octave
% A=[2 1 -4; 3 3 -5; 4 5 -2]; I=eye(3, 3);
% A=gauss_jordan(A, I)

function [A]=gauss_jordan_pivot(A, B)
A=horzcat(A, B) % matrice augmentee (A | B)

Epsilon=1.0e-6;
n=size(A, 1); % nb de lignes de A

for k=1:n
    i=find_pivot(A, k);
    
    A([i, k], :)=A([k, i], :); % permutation des lignes i et k
    
    if (abs(A(k,k))<Epsilon) error('akk trop petit !');
    end
    
    akk=A(k,k);
    A(k, :)=A(k, :)/akk;

    for i=1:n
        if (i==k) continue; 
        end
        aik=A(i, k);
        A(i, :)=A(i, :)-aik*A(k , :);
    end
    A % affichage de la matrice A transformee
end
end

function idx=find_pivot(A, k)
    [~, idx]=max(abs(A(k:end, k)));
    idx=idx+k-1;
end



