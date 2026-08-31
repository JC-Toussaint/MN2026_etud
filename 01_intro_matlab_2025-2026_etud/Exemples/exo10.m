% Exercice 10

v= rand(100,1);
m=rand(100);
a=zeros(length(v),1);

t=cputime ;
a=m*v;
t_produit=cputime-t
a=zeros(length(v),1);

t=cputime;
for n=1:length(v)
   for k=1:length(m)
      a(n)=a(n)+m(n,k)*v(k);
   end
end
t_boucle=cputime-t
