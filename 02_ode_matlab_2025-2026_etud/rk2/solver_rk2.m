function solver_rk2
clc
clear all
close all

param=[0 20 1.];
[T,Y] = rk2(@oscil,param,[1 0]);
plot(T,Y(:,1),'r+-',T,Y(:,2),'bo-')
hold on

title(['Methode RK2  h=' num2str(param(3))])

analytique(param)


x=Y(:,1);
v=Y(:,2);

p2=1;
E=v.^2+p2*x.^2;
figure
plot(T, E);

max(sort(E, 'descend')-E)

