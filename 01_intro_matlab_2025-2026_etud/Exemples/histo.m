function histo(x)

moyenne=mean(x(2,:));
ecart=std(x(2,:));

[ligne colonne]=size(x);
notes=x(ligne,:)

nb_inter=6;
frequence=zeros(nb_inter,1);
min=0;
max=20;
pas=(max-min)/nb_inter;
inter=[min+pas/2:pas:max-pas/2]
for i=1:colonne
   if notes(i)>=min & notes(i)<pas;
      frequence(1)=frequence(1)+1;
   elseif notes(i)>=pas & notes(i)<2*pas;
      frequence(2)=frequence(2)+1;
   elseif notes(i)>=2*pas & notes(i)<3*pas;
      frequence(3)=frequence(3)+1;
   elseif notes(i)>=3*pas & notes(i)<4*pas;
      frequence(4)=frequence(4)+1;
   elseif notes(i)>=4*pas & notes(i)<5*pas;
      frequence(5)=frequence(5)+1;   
   else notes(i)>=5*pas & notes(i)<=max;
      frequence(6)=frequence(6)+1;
   end
end

bar(inter,frequence);
xlabel('note');
ylabel('nombre d''evenements');

A=strcat('moyenne=',int2str(moyenne));
B=strcat('ecar type=',int2str(ecart));
text(2,8,A)
text(2,6,B)
