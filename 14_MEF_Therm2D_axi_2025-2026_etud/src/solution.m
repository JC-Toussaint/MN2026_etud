function fem=solution(fem)

%initialisation  
NP=fem.NP;
A=sparse(NP, NP);
B=zeros(NP, 1);

%INTEGRATION ET ASSEMBLAGE 
NE=fem.NE;
for ne=1:NE  
    % on calcul les integrales 
    [Ae,Be]= integrales(fem, ne);
    % on assemble et on tient compte des conditions aux limites
    [A,B]=assemblage(fem, ne, Ae, Be, A, B);    
end;

%CONDITIONS DE DIRICHLET
[A,B]=conditions(fem,A,B); 

%h=figure(2);
%hold off;
%set(h, 'Position',[0 50 500 400]);
% localisation des elements non-nuls de la matrice A
%spy(A);
%title('Avant les conditions aux limites');
%hold on;

%RESOLUTION DU SYSTEME LINEAIRE 
sol=A\B;

% setup.type = 'crout';
% setup.milu = 'row';
% setup.droptol = 1e-5;
% [L,U] = ilu(A,setup);
% 
% [sol, flag]=bicgstab(A, B,1e-6,fem.NP, L, U);
% if flag
%     error('probleme de convergence!');
% end;

fem.sol=sol';
