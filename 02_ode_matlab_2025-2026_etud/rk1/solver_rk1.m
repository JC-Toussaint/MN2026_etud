function solver_rk1
clc
clear all
close all

param=[0 25 0.05];
[T,Y] = rk1(@oscil,param,[1 0]);
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

