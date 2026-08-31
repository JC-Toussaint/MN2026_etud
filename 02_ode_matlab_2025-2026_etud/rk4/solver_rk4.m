function solver_rk4
hold off
figure(1)

param=[0 20 0.1];
[T,Y] = rk4(@oscil,param,[1 0]);
plot(T,Y(:,1),'r+-',T,Y(:,2),'bo-')
hold on

analytique(param)
title(['Methode RK2  h=' num2str(param(3))])
