%   Resolution de systeme lineaire
%   Methode de Gauss factorisation LU sans pivot
%
%   Fontions appellees : 
%   falusp : Factorisation LU sans pivot
%   drlusp : Methode descente remontee sans pivot

% Matrice A
A = [10 7  8  7 ; 
      7 5  6  5; 
      8 6 10  9; 
      7 5  9 10] ;
% A=[5  2 1 ; 
%    5 -6 2 ; 
%   -4  2 1];

n = size(A,1) ;
x_ref = ones(n,1) ; 

% calcul du 2nd membre
b = A*x_ref ;
b = b + [0.32 -0.23 0.33 -0.31]';

% Factorisation LU sans pivot
[L,U] = LUsp(A) ;

% Methode de descente remontee
x_cal = solve(L,U,b) ;
err_inf = norm(x_cal - x_ref, inf);
res_inf = norm(b - A*x_cal, inf);

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
