clc
clear all
close all

% parametres physiques
kth=401;
rho=8933;
cp =385;

% geometrie
longueur = 0.1;
N=100;
deltax = longueur/(N-1);
xp =[0:N-1]*deltax;

% duree
duree=5;
deltat = 0.01;

% CL Dirichlet
Tdg = 300;
Tdd = 300;
% CI
Tprec=zeros(N, 1);
Tprec(:)=500;

T=zeros(N, 1);
t=0;
while t<duree
    T(1)=Tdg;
    T(N)=Tdd;

    for p=2:N-1  % noeuds interieurs
        d2T_dx2 = (Tprec(p+1)+Tprec(p-1)-2*Tprec(p))/deltax^2;
        T(p) =Tprec(p) + deltat*kth/(rho*cp)*d2T_dx2;
    end

    plot(xp, T, 'r')
    grid on
    drawnow;
    Tprec(:)=T(:);
    t = t +deltat;
end













