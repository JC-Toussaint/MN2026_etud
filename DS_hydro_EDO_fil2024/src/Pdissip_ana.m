function Q = Pdissip_ana(R)

param.R=R;
param.f=50;
param.rho=1e3;
param.eta=1;
param.fz0=1e5;

tol=1e-6;
verbose=0;
Q = quad(@integrand, 0, R, tol, verbose, param)
N=100;
dr=R/N;
r=0:dr:R;
f=integrand(r, param);
plot(r, f, 'r')
end

function f = integrand(r, param) 
R=param.R;
f=param.f; omega=2*pi*f;
rho=param.rho;
eta=param.eta;
fz0=param.fz0;

K=sqrt(1i*omega*rho/eta);
pref=-pi*abs(K/besselj(0, K*R))^2*(eta*fz0/(omega*rho))^2;
f = pref*r.*abs(besselj(1, K*r)).^2;
end