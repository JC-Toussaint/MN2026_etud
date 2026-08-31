clear all
clc

A =[1 2 3;
    0 1 1; 
    0 0 2];
 
b =[1 2 3]';

n = size(A,1);
x = zeros(n,1);
 
x(n)=b(n)/A(n,n);
for k = n-1:-1:1
%     l=k+1:n;
%     v=A(k,l)*x(l);
    v=0;
    for l=k+1:n
        v=v+A(k,l)*x(l);
    end
    x(k)=(b(k)-v)/A(k,k);
end

b-A*x