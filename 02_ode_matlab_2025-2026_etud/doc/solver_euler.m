%function solver_euler
clc
clear all
close all
format long

h =0.2;
tf=2;

param(1)=0;     
param(2)=tf;    
param(3)=h;    

y0=1; % Cond initiale
[T, Y]=euler(param, y0);

plot(T, Y, 'o');
grid on

hold on
t=0:0.01:tf;
y=1./(t+1);

plot (t, y, 'r');

eps=1e-6;
n=find(abs(t-tf)<eps)
p=find(abs(T-tf)<eps)

err=y(n)-Y(p)



