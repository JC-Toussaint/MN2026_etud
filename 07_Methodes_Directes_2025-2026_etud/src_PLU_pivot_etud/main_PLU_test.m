clc
clear all

A=[1 1/4 0 0; 1 5/4 12 0; 1 1/3 1 1; 1 5/4 13 1];

[P, L, U]=PLU(A)

P*L*U-A