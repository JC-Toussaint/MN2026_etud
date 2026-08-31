% etude de la stabilite

clear
%2eme cas
n=0.2;
p2=1;

%n=1.5;
%p2=2;

r1=-n-sqrt(n*n-p2);
r2=-n+sqrt(n*n-p2);

alpha=real(r1);
beta=imag(r1);

lambda=(alpha+i*beta);

h=0:0.05:0.5;

% ordre 1
poly1=abs(1+h*lambda);

subplot(3,1,1);
plot(h,poly1,'m');
grid on
ylabel('z');
title('Polynome ordre 1');

% ordre 2
h=0:0.05:1.5;
poly2=abs(1+h*lambda+0.5*h.^2*lambda^2);

subplot(3,1,2);
plot(h,poly2,'m');
grid on
ylabel('z');
title('Polynome ordre 2');

% ordre 4
h=0:0.05:3;
poly4=abs(1+h*lambda+0.5*h.^2*lambda^2+01/6*h.^3*lambda^3+1/24*h.^4*lambda^4);

subplot(3,1,3);
plot(h,poly4,'m');
grid on
xlabel('pas de temps');
ylabel('z ');
title('Polynome ordre 4');