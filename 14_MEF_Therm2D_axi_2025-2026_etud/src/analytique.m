% expression analytique de la temperature 
% pour la sphere axi

function [err]=analytique(fem)

hold off;

Ri=10;
Re=50;
kth1=400;
kth2=200;

qth=1e3;
hcv=10;
Ta=300;

%%% DEBUT DU BLOC A RECOPIER DANS VOTRE COPIE %%%  

%%% FIN DU BLOC A RECOPIER DANS VOTRE COPIE %%% 

plot(r, T, 'r');
grid on
title('analytique');

end
