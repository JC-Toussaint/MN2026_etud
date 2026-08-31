function [x, iter]=cgm(fem, A, b)
% Resolution avec la methode du gradient conjugue

NP=fem.NP;

% liste des noeuds de Dirichlet et valeurs
ld=fem.cld.ind;
vd=fem.cld.val;

xd=zeros(NP, 1);
% slicing, affectation des valeurs vd qu'aux noeuds de ld
xd(ld)=vd; % les valeurs de xd en dehors des noeuds de ld sont nulles

% correction du vecteur b pour tenir compte des cond dirichlet
bd=b-A*xd;

% liste des degres de liberte (dof) = 
% difference(ens de tous les noeuds, ens des noeuds dirichlet)
dof = setdiff([1:NP], ld);

% sous-matrice et sous-vecteur associes aux noeuds ou x est inconnu
Ap = A(dof, dof);
bp = bd(dof);

% resolution de Ap xp = bp, taille de xp = nb de dof
% en utilisant le gradient conjugué cgs de Matlab

maxiter=fem.NP;    % nb max d'iterations pour cgs
tol=1e-6;          % tolerance
[xp, flag, relerr, iter] = cgs(Ap, bp, tol, maxiter)
if (flag~=0)
     error('non convergence')
end    
format long;
disp([' erreur relative '  num2str(relerr)]);

% Le vecteur solution est de taille NP
x=zeros(NP, 1);
% affectation des valeurs de x aux noeuds de dirichlet
x=xd;
% completion avec les valeurs aux noeuds dof
x(dof)=xp; 

end
