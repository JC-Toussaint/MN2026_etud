function analytique(param)

t0 = param(1);
tf = param(2);
h  = 0.05;
% 1er cas
%n=1.5;
%p2=2;

%2eme cas
n=0.2;
p2=1;

r1=-n-sqrt(n*n-p2);
r2=-n+sqrt(n*n-p2);

%2nd cas
t=t0:h:tf;
x=-r2/(r1-r2)*exp(r1*t)+r1/(r1-r2)*exp(r2*t);
v=-r2*r1/(r1-r2)*exp(r1*t)+r1*r2/(r1-r2)*exp(r2*t);

e=v.*v+p2*x.^2;

plot(t,e,'b')
legend('energie')
xlabel('t')
grid on
