% euler integration ordre 1

function solver_euler
clc         % efface la fenetre de commande
clear all   % efface la memoire
close all   % ferme les fenetres graphiques

tf=2.;
h =0.1;
y0=1;

param=[0 tf h];
[T, Y] = euler(param, y0);
plot(T, Y,'bo-')
hold on

% pour tracer la solution analytique
% prendre un pas d'echnatillonnage petit
t=0:0.01:tf;
yana=1./(t+1);
plot(t, yana, 'r');

title(['Methode Euler  h=' num2str(param(3))])
end

function [tvec, yvec]=euler(param, y0)
% intervalle d'etude en temps et pas
t0 = param(1);
tf = param(2);
h  = param(3);

% stockage
n=1;
tvec(n)=t0;
yvec(n)=y0;

% initialisation
t=t0;
y=y0;

while (t<tf)
    y = y -h*y*y;
    
    n=n+1;
    t=t+h;
    
    tvec(n)=t;
    yvec(n)=y;
end;
end


