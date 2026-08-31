clc
close all

NLA=100;
NCA=200;

NLB=NCA;
NCB=300;

A=rand(NLA, NCA);
B=rand(NLB, NCB);

tic
for i=1:10
R=mult(A, B);
end;
toc

tic
for i=1:10
R=mult2(A, B);
end;
toc
