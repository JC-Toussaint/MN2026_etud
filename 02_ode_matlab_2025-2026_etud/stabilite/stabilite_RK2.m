% stabilite RK2

clear
hold off

%2eme cas
n=0.2;
p2=1;

r1=-n-sqrt(n*n-p2);
r2=-n+sqrt(n*n-p2);

% ordre 2
h=0:0.001:2.5;
un=ones(length(h), 1);
plot(h, un, 'r');
hold on

lambda=r1;
P=abs(1+h*lambda+0.5*h.^2*lambda^2);
plot(h,P,'b');

lambda=r2;
P=abs(1+h*lambda+0.5*h.^2*lambda^2);
plot(h,P,'b');

grid on
xlabel('h');
title(['Stabilite RK2 ' ...
    'n=' num2str(n) ' p2=' num2str(p2)]);

