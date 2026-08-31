% Methode du gradient conjugue
clc
clear all
close all

% systeme a resoudre
A=[2  0; 
   0  1];
   
b=[1 0]';

% point de depart x0
x=[1 1]';

% on efface les tableaux
clear xn yn en g;

% tolerance
tol=1e-6;

% initialisation 
r=b-A*x;
p=r;

k=1;
xn(k)=x(1);
yn(k)=x(2);
en(k)=0.5*x'*A*x-x'*b;

erreur(k)= norm(r)/norm(b);

% processus de minimisation
while (norm(r)/norm(b) > tol)
    
% BLOC A COMPLETER DEBUT    p_k et r_k


    
% BLOC A COMPLETER FIN

    k=k+1;
    xn(k)=x(1);   %  xn = [xn x(1)];
    yn(k)=x(2);
    en(k)=0.5*x'*A*x-x'*b;    
    erreur(k)=norm(r)/norm(b)
end  

disp (['nombre d''iterations'  num2str(k-1)]);
nb_iter=1:k;
semilogy(nb_iter,erreur);
grid on

figure1 = figure('PaperSize',[20.98 29.68],'Color',[1 1 1], 'Position', [1 1 600 600]);

hold off
[x,y] = meshgrid([-0.5:.05:1], [-0.5:.05:1]);
Z =0.5*(A(1,1)*x.*x+A(1,2)*x.*y+A(2,1)*y.*x+A(2,2)*y.*y)-b(1)*x-b(2)*y;
surf(x,y,Z,Z, 'FaceColor','interp')
hold on;
plot3(xn, yn, en, 'w-', 'LineWidth',2)
colorbar

figure
[x,y] = meshgrid([-0.5:.01:1], [-0.5:.01:1]);
Z =0.5*(A(1,1)*x.*x+A(1,2)*x.*y+A(2,1)*y.*x+A(2,2)*y.*y)-b(1)*x-b(2)*y;
[C,h] =contour(x, y, Z, en);
set(h,'ShowText','on','TextStep',get(h,'LevelStep')*2);
colormap jet
hold on;
plot(xn, yn, 'b-', 'LineWidth',2)
