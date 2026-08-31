% systeme a resoudre
A=[2 0; 
   0 1];
b=[1 0]';
 
% point de depart x0
x=[1 1]';
 
% on efface les tableaux
clear xn yn en;
 
% tolérance
tol=1e-6;
 
% initialisation 
r=b-A*x;
p=r;
rho1=r'*r;

n=1;
xn(n)=x(1);
yn(n)=x(2);
en(n)=0.5*x'*A*x-x'*b;
 
% processus de minimisation
while (norm(r)/norm(b) > tol)
    alpha=rho1/(p'*A*p);
    x=x+alpha*p;
    r=b-A*x;
    rho=r'*r;   
    beta=rho/rho1;
    p=r+beta*p;
    rho1=rho;   
     
    n=n+1;
    xn(n)=x(1);
    yn(n)=x(2);
    en(n)=0.5*x'*A*x-x'*b;    
end   
 
disp (['nombre d''iterations'  num2str(n-1)]);

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
[C,h] =contour(x, y, Z, en)
set(h,'ShowText','on','TextStep',get(h,'LevelStep')*2)
colormap jet
hold on;
plot(xn, yn, 'b-', 'LineWidth',2)
