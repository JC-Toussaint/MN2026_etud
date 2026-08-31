% Gradient conjugue avec preconditionnement sur des systemes de grande taille

format long
clc
%close all

% random avec le meme graine
rand ('seed',12563);
randn('seed',12563);

% taille du systeme
N=400;
density=0.01;
A = sprandn(N,N,density);
 
% pour rendre A symetrique
A=0.5*(A+A');  
 
% HACK pour rendre A definie positive
D=sum(abs(A(:,1:N)));
for i=1:N
    A(i,i)=D(i)-A(i,i);
end;
 
% Preconditionneur
M=diag(1./diag(A));

disp (['nb d''elts non nuls ' num2str(nnz(A))]);
disp (['condionnement avant '  num2str(max(eig(A))/min(eig(A)))]);
disp (['condionnement apres '  num2str(max(eig(M*A))/min(eig(M*A)))]);
 
%M=inv(A);
 
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
p=M*r;
rho1=p'*r;

k=1;
xn(:, k)=x;
en(k)=0.5*x'*A*x-x'*b;

% processus de minimisation
while (norm(r)/norm(b) > tol)
    alpha=rho1/(p'*A*p);
    x=x+alpha*p;
    r=b-A*x;
    rho=r'*M*r;
    beta=rho/rho1;
    p=M*r+beta*p;   
    rho1=rho;
    
    k=k+1;
    xn(:, k)=x;
    en(k)=0.5*x'*A*x-x'*b;    
end   
  
disp (['nombre d''iterations'  num2str(k-1)]);
 
ef=en(end); % valeur finale
 
% trace en echelle log10
semilogy(abs(en-ef));
grid on

