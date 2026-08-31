clc
clear all
close all

% random avec la meme graine
rand ('seed',12563);
randn('seed',12563); 

% taille du systeme
N=400;  density=0.01;
A = sprandn(N,N,density);
 
% pour rendre A symetrique
A=0.5*(A+A');  
 
% pour rendre A definie positive
D=sum(abs(A(:,1:N)));
for i=1:N
    A(i,i)=D(i)-A(i,i);
    %A(i, i)=D(i);
end
 
disp (['nb d''elts non nuls ' num2str(nnz(A))]);
disp (['condionnement de A '  num2str(max(eig(A))/min(eig(A)))]);
 
% construction de b
b=rand(N, 1);
 
% point de depart x0
x=rand(N, 1);
 
% on efface les tableaux
clear xn en;
 
% tolérance
tol=1e-6;
 
% initialisation 
r=b-A*x;  
p=r;
rho1=r'*r;

k=1;
xn(:, k)=x;
en(k)=0.5*x'*A*x-x'*b;
erreur(k)=norm(r)/norm(b);

% processus de minimisation
while (norm(r)/norm(b) > tol)
    alpha=rho1/(p'*A*p);
    x=x+alpha*p;
    r=b-A*x;
    rho=r'*r;   
    beta=rho/rho1;
    p=r+beta*p;
    rho1=rho;   
     
    k=k+1;
    xn(:, k)=x;
    en(k)=0.5*x'*A*x-x'*b; 
    erreur(k)=norm(r)/norm(b)
end 
   
disp (['nombre d''iterations'  num2str(k-1)]);
 
% trace en echelle log10
ef=en(end); % valeur finale
semilogy(abs(en-ef));
title('energie en fct du nb iterations')
grid on

% trace en echelle log10
figure
semilogy(erreur);
title('erreur en fct du nb iterations')
grid on


