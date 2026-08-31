function [x, T]=solver(fd)

% |--------L--------|
%
% o--|--|--|--|--|--|
% 0  1  2  3  4  5  N=6
%
% L = N.h
%

theta =fd.theta;
lambda=fd.lambda;
L=fd.L;
N=fd.N;
h=L/N;

tf=fd.tf; 
k=fd.k;

x=linspace(0, fd.L, N);

% Distribution initiale de temperature
a    = 100; % K
Tmoy = 300; %K
T=a*sin(2*pi/L*x)'+Tmoy;

Id=speye(N);
Delta=lap1(N)/h^2;

t=0;
tvec=[t];
% A COMPLETER

while t<tf
    
    A=Id-lambda*theta*k*Delta;
    b=lambda*Delta*T;
    v=A\b;
    
    T=T+k*v;
    t=t+k;
    
    % post-traitement
    tvec=[tvec t];
    % A COMPLETER
    
    subplot(1, 2, 1)
    plot(x, T, 'r-');
    grid on
    ylim([Tmoy-a Tmoy+a])
    title('distribution')
    
    subplot(1, 2, 2)
    grid on
    % A COMPLETER
    title('coenergie')
    
    pause(1)

end
