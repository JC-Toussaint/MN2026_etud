% solver_rk1 main program
clc
clear all
close all

tf = 100; h = 0.41;
param=[0 tf h]; % paramètres temporels

x0 = 1; v0 =0; % conditions initiales
Y0 = [x0 v0];
[T,Y] = rk1(@oscil, param, Y0);

plot(T,Y(:,1),'r+-',T,Y(:,2),'bo-')
hold on

title(['Methode RK1  h=' num2str(param(3))])
analytique(param)

x=Y(:,1);
v=Y(:,2);

p2=1;
E=v.^2+p2*x.^2;
figure
plot(T, E); % energie pas forcement decroissante!

