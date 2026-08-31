function x=resol(a,n)
b=zeros(n,1);
b(1)=1;
T=diag(-ones(n-1,1),1)+diag(-ones(n-1,1),-1)+2*eye(n);
T=a*T;
x=T\b;
