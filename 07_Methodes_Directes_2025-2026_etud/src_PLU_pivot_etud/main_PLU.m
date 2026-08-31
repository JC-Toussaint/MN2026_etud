%   Resolution de systeme lineaire
%   Methode de Gauss factorisation LU sans pivot
%
%   Fontions appellees : 
%   falusp : Factorisation LU sans pivot
%   drlusp : Methode descente remontee sans pivot

% Matrice A
% A = [10 7 8 7 ; 
%         7 5 6 5; 
%       8 6 10 9; 
%      7 5 9 10] ;
% A=[5  2 1 ; 
%    5 -6 2 ; 
%   -4  2 1];

A=[1 1/4 0  0; 
   1 5/4 12 0; 
   1 1/3 1  1; 
   1 5/4 13 1];

n = size(A,1) ;
x_ref = ones(n,1) ; 

% calcul du 2nd membre
b = A*x_ref ;

% Factorisation LU sans pivot
[P, L, U] = PLU(A) ;

% Methode de descente remontee
x_cal = solve(P, L, U, b) ;
err_inf = norm(x_cal - x_ref, inf) ;
res_inf = norm(b - A*x_cal, inf) ;

%
% Affichage 
% 
disp(' ') ; disp(' ') ;
disp('Erreur sur la solution')
msg = sprintf('                   %22.14e',err_inf) ;
disp(msg) ;
disp(' ') ; disp(' ') ;
disp('Norme Max du residu')
msg = sprintf('                   %22.14e',res_inf) ;
disp(msg) ;
