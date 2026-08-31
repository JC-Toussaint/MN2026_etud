function solver_rk1
clc
clear all
close all

% notations de l'equation
% x=y(1);
% v=y(2);

%2eme cas
n=0.2;
p2=1;

tf=20;
h=0.5;

for n=1:10
    n

    param=[0 tf h];
    [T,Y] = rk2(@oscil,param,[1 0]);
    x=Y(:,1);
    v=Y(:,2);
    e=v.*v+p2*x.^2;
    ne=tf/h+1;
    hvec(n)=h;
    evec(n)=e(ne);
    
    h=h/2;
% plot(T,e,'r.')
% legend('energie')
% hold on
% 
% analytique(param)
% title(['Methode RK1  h=' num2str(param(3))])

    end;
    
    plot(log(hvec), log(evec(end)-evec), 'o');
    

lh=log(hvec(1:end-1)); 
err=evec(end)-evec;
le=log(err(1:end-1)); 

p=polyfit(lh, le, 1);
p(1)
