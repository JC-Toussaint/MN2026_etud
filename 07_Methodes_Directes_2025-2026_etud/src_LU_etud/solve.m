function x = solve(L, U, b)

% Resolution d'un systeme lineaire suite a la factorisation LU de sa matrice
% par Descente-Remontee 
%
% ENTREE
%   L : Matrice triangulaire inferieure (sortie de LUsp)
%   U : Matrice triangulaire superieure (sortie de LUsp)
%   b    : second membre du systeme
% 
% SORTIE 
%   x : solution du systeme
%
% APPEL 
%   x=solve(L,U,b) : renvoie dans x la solution de Ax=b ou L,U sont les 
%   matrices triangulaires inf et sup de la matrice A 
% 
% LU x = b     L y = b
n = size(L,1) ;

%
% Resolution par descente remontee LUx=b
%
% Descente Ly=b

% A COMPLETER

% Remontee Ux=y

% A COMPLETER

end


