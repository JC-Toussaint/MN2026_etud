% Illustration de la notion de conditionnement
% FAIRE TAPER AUX ETUDIANTS CE QUI SUIT
% Test avec la matrice 4x4 du cours 

A = [10 7 8 7 ; 
      7 5 6 5; 
      8 6 10 9; 
      7 5 9 10] ;

x = [1 ; 1; 1 ;1] ;  % Solution que l'on veut retrouver

b=A*x ; % Second membre correspondant

determinant=det(A) 
inverse_de_A=inv(A) % une bonne tete

% OUI mais, la matrice est tres mal conditionnee

solution=A\b % on retrouve bien x

% On perturbe 
db = [0.5;-0.1;0.1;-0.1] % la perturbation relative est 0.015

dx=A\(b+db) - x  % la perturbation relative est max(abs(dx))/max(abs(x))

erreur_relative_b = max(abs(db))/max(abs(b))
erreur_relative_x = max(abs(dx))/max(abs(x))

rapport_erreur_relative = erreur_relative_x/erreur_relative_b

Valeur_Propre = eig(A)  % valeurs propres de A

Cond_A = max(Valeur_Propre)/min(Valeur_Propre)