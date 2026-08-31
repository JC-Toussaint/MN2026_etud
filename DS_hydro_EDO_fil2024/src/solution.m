% fem = solution(fem)
% Calcul de la solution de l'equation de la chaleur
% Entree et Sortie/
% structure fem 
    
function fem=solution(fem)

%initialisation  
NP=fem.NP;
A=zeros(NP, NP);
B=zeros(NP, 1);

%INTEGRATION ET ASSEMBLAGE 
NE=fem.NE;
for ne=1:NE  
    % on calcul les integrales 
    [Ae,Be]= integrales(fem, ne);
    % on assemble et on tient compte des conditions aux limites
    [A,B]=assemblage(fem, ne, Ae, Be, A, B);    
end;

h=figure(2);
hold off;
set(h, 'Position',[0 50 500 400]);
% localisation des elements non-nuls de la matrice A
spy(A);
title('Avant les conditions aux limites');
hold on;

%PRISE EN COMPTE DES CONDITIONS AUX LIMITES DE DIRICHLET
[A,B]=conditions(fem,A,B);

h=figure(5);
hold off;
set(h, 'Position',[0 50 500 400]);

% localisation des elements non-nuls de la matrice A
% apres application des conditions aux limites Dirichlet
spy(A);
title('Apres les conditions aux limites');

%RESOLUTION DU SYSTEME LINEAIRE
sol = A\B;
fem.sol = sol';
