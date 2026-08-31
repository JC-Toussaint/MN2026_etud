% euler integration ordre 1

clc         % efface la fenetre de commande
clear all   % efface la memoire
close all   % ferme les fenetres graphiques

tf=2.;
h =0.1;
y0=1;

% stockage
n=1;
tvec(n)=0;
yvec(n)=y0;

% initialisation
t=0;
y=y0;

while (t<tf)
    y = y -h*y*y;
    
    n=n+1;
    t=t+h;
    
    tvec(n)=t;
    yvec(n)=y;
end;

plot(tvec, yvec, 'bo-');
hold on   % on garde le graphe

% pour tracer la solution analytique
% prendre un pas d'echnatillonnage petit
t=0:0.01:tf;
yana=1./(t+1);
plot(t, yana, 'r');
