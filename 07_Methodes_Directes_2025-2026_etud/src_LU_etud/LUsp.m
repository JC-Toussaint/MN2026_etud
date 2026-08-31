function [L,U] = LUsp(A)

% Factorisation LU SANS PIVOT de la matrice A

n = size(A,1) ;
% Initialisation de la matrice L
Id=eye(n);
L=Id;
ier = 0 ;
Epsilon=1.0e-6;
for k = 1:n-1
    if (abs(A(k,k))<Epsilon)
        error('akk trop petit !');
    end
        
    % A COMPLETER
    
end
% La derniere matrice A(k+1) est la matrice triangulaire superieure
U=A;
end






