% ----------
% Exercice 9
% ----------

x=[-50 -3 -2 -1 -1.001 -1.999 0.1 0.5 1 5 10];
nbx=length(x);

for i=1:nbx
   valeur=x(i)
   if x(i)>-5 & x(i)<=-1
      string=sprintf('%s','intervalle 1')
      y(i)=x(i)*exp(x(i)+1);
   elseif x(i)>-1 & x(i)<1
      string=sprintf('%s','intervalle 2')
      y(i)=2*x(i);
   elseif x(i)>=1 & x(i)<=10
      string=sprintf('%s','intervalle 3')
      y(i)=x(i)*exp(-x(i)+1);
   else x(i)<=-5 & x(i)>10
      %warning('WARNING : en dehors de l''intervalle')
      sprintf('%s','MESSAGE : en dehors de l''intervalle')
      %error('ERROR : en dehors de l''intervalle')
   end
end

