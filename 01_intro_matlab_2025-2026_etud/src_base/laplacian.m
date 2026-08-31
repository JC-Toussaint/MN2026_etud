clc
N=10;
L=diag(ones(N-1,1),1)+diag(ones(N-1,1),-1)-2*eye(N);
L(1, 1)=1;
L(N, N)=1;
L