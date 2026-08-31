clc
clear all

A=[1 1/4 0  0; 
   1 5/4 12 0; 
   1 1/3 1  1; 
   1 5/4 13 1];

B=[0 0 1 0]';
n=size(A, 1)

[R]=gauss_jordan_pivot(A, B)
x=R(1:n, n+1:end)

A*x-B