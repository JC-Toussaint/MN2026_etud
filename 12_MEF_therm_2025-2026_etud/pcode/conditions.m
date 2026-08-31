function [A,B]=conditions(fem,A,B) 
              

%moyenne des termes diagonaux */
NP=fem.NP;      % dimension du systeme   
NCLD=fem.NCLD;  % nombre de conditions de Dirichlet
cld =fem.cld;   % extraction des CAL Dirichlet

for npc=1:NCLD
   num = cld.ind(npc);
   val = cld.val(npc);
   %on remplace la ligne concernee du systeme lineaire
    %par l'expression de la condition a la limite
   A(num,:)=0; 
   A(num,num) = 1.0;
   B(num)= val;
end;
