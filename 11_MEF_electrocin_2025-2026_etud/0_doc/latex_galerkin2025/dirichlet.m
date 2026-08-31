clc
close all
clear all;

N=6;
ld=[1, 4];
V0=zeros(N , 1);
V0(ld)=1;

A=rand(N, N);
A=A+A';

B0=rand(N, 1);
B=B0-A*V0;
P=eye(N, N);
P(ld, :)=[];

Ap=P*A*P';
Bp=P*B;

Vp=Ap\Bp;
V1=P'*Vp+ V0

B=B0;
A(ld, :)=0;
B(ld)=0;
B=B+V0;
for i=1:length(ld)
    A(ld(i), ld(i))=1;
end;

V2=A\B

V1-V2



