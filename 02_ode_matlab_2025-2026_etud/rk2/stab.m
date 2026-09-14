clc
clear all
close all

p2 = 1;
n  = 0.2;

A = [0     1;
    -p2 -2*n];

lb = eig(A)
h = linspace(0, 2, 1000);

G1 = abs(1 + h*lb(1) + 0.5*(h*lb(1)).^2 );
G2 = abs(1 + h*lb(2) + 0.5*(h*lb(2)).^2 );

plot(h, G1, 'r');
hold on;
plot(h, G2, 'b');
grid on









