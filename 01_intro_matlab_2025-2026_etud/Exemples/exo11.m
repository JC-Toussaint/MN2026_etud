% -----------
% Exercice 12
% -----------

% recherche du zero d une fonction
% on peut mettre un intervalle a condition
% qu il y ai changement de signe pour f(x)
% par exemple l intervalle [-3 3] ne marche pas
%pour la fonction f1 [-2 2] ok
% pour f2 [-2 2] ne marche pas
 z = fzero('fonction',[-3 -1]);                 
 fplot('fonction',[-3 3])
 hold on; % sinon le graphique disparait
 
 plot(z,0,'g*'); % afichage du zero en vert avec *     
 
 % recherche du minimum d une fonction
 min = fminbnd('fonction',-3,2);               
 fplot('fonction',[-3 3]);                   
 plot(min,fonction(min),'r+'); % affichage du min 
 
 % recherche du maximum d une fonction
 % attention l intervalle [-3 3] fonctionne pour f1
 % mais pas pour f2 il faut mettre par exemple [0 3]
 [x,y]=fplot('fonction',[0 3]);
 [Max,position]=max(y)
 plot(x(position),Max,'mo'); % affichage du min
 
 grid on
 hold off
 