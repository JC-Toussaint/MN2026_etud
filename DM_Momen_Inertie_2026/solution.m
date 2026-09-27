function [fem]=solution(fem)

Xg = 0.;
Yg = 0.;
Izz= 0.;
S  = 0.;

NE=fem.NE;
for ne = 1:NE % boucle sur tous les elements
        
	% Calcul de l'integrale elementaire et de la surface
	[Ix, Iy, Ir2, Se]=integrale(fem, ne);

	% Accumulation
	Xg = Xg  + Ix;
	Yg = Yg  + Iy;
	Izz= Izz + Ir2;
	S  = S   + Se; % Calcul de la surface
end

fem.Xg = Xg/S;
fem.Yg = Yg/S;
fem.Izz=Izz;
fem.S=S;
end

