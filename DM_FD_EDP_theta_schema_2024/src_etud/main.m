clc
close all
clear all

% |--------L--------|
%
% o--|--|--|--|--|--|
% 0  1  2  3  4  5  N=6
%
% L = N.h
%
fd.theta=0.5;

fd.lambda=1;
fd.L=1;
fd.N=1000;

fd.tf=1; 
fd.k=1e-3; % pas de temps

[x, T]=solver(fd);
