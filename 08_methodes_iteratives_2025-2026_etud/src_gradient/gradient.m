% Methode du gradient

clear all;
close all;

% systeme a resoudre
A=[2 -1; 
  -1  2];

b=[1 0]';

% point de depart x0
x=[1 1]';
 
% processus de minimisation
tol=1e-6;

k=1;
r=b-A*x;
residu(:,k)=r;

erreur(k)= norm(r)/norm(b);

while (norm(r)/norm(b) > tol)
    xn(k)=x(1);
    yn(k)=x(2);
    en(k)=0.5*x'*A*x-x'*b;

% BLOC A COMPLETER DEBUT


% BLOC A COMPLETER FIN

    k=k+1;
    erreur(k)= norm(r)/norm(b);
    residu(:,k)=r;
    rtr=residu(:,k)'*residu(:,k-1);
    disp (['rT(k+1)r(k) : '  num2str(rtr)]);
end   

nb_iter=1:k;
semilogy(nb_iter,erreur)
grid on

disp (['nombre d''iterations'  num2str(k)]);

figure1 = figure('PaperSize',[20.98 29.68],'Color',[1 1 1], 'Position', [1 1 600 600]);

hold off
[x,y] = meshgrid([-0.5:.05:1], [-0.5:.05:1]);
Z =0.5*(A(1,1)*x.*x+A(1,2)*x.*y+A(2,1)*y.*x+A(2,2)*y.*y)-b(1)*x-b(2)*y;
surfc(x,y,Z,Z, 'FaceColor','interp')
hold on;
plot3(xn, yn, en, 'w-', 'LineWidth',2)
colorbar

figure
[x,y] = meshgrid([-0.5:.01:1], [-0.5:.01:1]);
Z =0.5*(A(1,1)*x.*x+A(1,2)*x.*y+A(2,1)*y.*x+A(2,2)*y.*y)-b(1)*x-b(2)*y;
[C,h] =contour(x, y, Z, en);
set(h,'ShowText','on','TextStep',get(h,'LevelStep')*2)
colormap jet
hold on;
plot(xn, yn, 'b-', 'LineWidth',2)

