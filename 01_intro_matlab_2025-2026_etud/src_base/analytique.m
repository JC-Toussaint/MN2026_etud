clear

% 1er cas
n=1.5;
p2=2;

%2eme cas
n=0.2;
p2=1;

r1=-n-sqrt(n*n-p2);
r2=-n+sqrt(n*n-p2);

% definition du temps pour le 1er cas
%t=0:0.1:7;

%2nd cas
t=0:0.1:7;
s=-r2/(r1-r2)*exp(r1*t)+r1/(r1-r2)*exp(r2*t);
ds_dt=-r2*r1/(r1-r2)*exp(r1*t)+r1*r2/(r1-r2)*exp(r2*t);

figure(2);
plot(t,s,'r',t,ds_dt,'b')
title('Resolution EDO : Solution analytique')
legend('position','vitesse')
xlabel('Temps (s)')
grid on
