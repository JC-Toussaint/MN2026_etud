% etude de la stabilite

clear

%1er cas
%n=1.5;
%p2=2;

%2eme cas
n=0.2;
p2=1;

r1=-n-sqrt(n*n-p2);
%r2=-n+sqrt(n*n-p2);

lambda=r1;

h=0:0.05:1;

% ordre 1
poly1=abs(1+h*lambda);

subplot(3,1,1);
plot(h,poly1,'m');
grid on
ylabel('z');
title('Polynome ordre 1');
