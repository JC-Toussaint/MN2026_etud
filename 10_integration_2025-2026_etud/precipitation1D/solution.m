function I=solution(fem)
% entree
% structure fem
% sortie
% I estimation de l'integrale

I = 0.0;
NE=fem.NE;
for ne = 1:NE % boucle sur tous les elements
        
	% Calcul de l'integrale elementaire
    [Ie]=integrale(fem,ne);

	% Accumulation
	I = I + Ie; % Calcul de la precipitation    
end
end
