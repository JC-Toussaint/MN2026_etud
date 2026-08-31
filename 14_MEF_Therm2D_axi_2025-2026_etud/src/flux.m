% flux a travers toutes les parois
function [qn]= flux(fem)  

%initialisation obligatoire du flux qn
qn =0;

NE=fem.NE;
for ne=1:NE
    e=fem.elt(ne);
    NBN=e.NBN;

%%% DEBUT DU BLOC A RECOPIER DANS VOTRE COPIE %%%
%%% FIN DU BLOC A RECOPIER DANS VOTRE COPIE %%%
  
end; 

end           
