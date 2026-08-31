%function solver_euler2
clc
clear all
close all
format long

tf=2;

h =0.2;
for n=1:8
    h=h/2;
    
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
    i=find(abs(t-tf)<eps)
    j=find(abs(T-tf)<eps)

    pas(n)=h;
    err(n)=y(i)-Y(j);
end

figure
plot(pas, err, 'o-');



