function x=resol(a,n)
b=1:n;
b=(b==1)';
T=diag(-ones(n-1,1),1)+diag(-ones(n-1,1),-1)+2*eye(n);
T=a*T;
x=T\b;
