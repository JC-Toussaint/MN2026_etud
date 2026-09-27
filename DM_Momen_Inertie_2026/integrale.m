function [Ix, Iy, Ir2, Se]=integrale(fem, ne)

% Calcul des grandeurs elementaires sur l'element (ne) :
%   Se     : aire de l'element
%   Ix, Iy : moments statiques elementaires (utilises pour Xg, Yg)
%   Ir2    : moment quadratique polaire elementaire par rapport au
%            point O(fem.Xo, fem.Yo)

% Fonction appelee
% -----------------
% polynomes_T3 :
% Calcul des polynomes sur element triangulaire
% et calcul du determinant du Jacobien

Ix  = 0.;
Iy  = 0.;
Ir2 = 0.;
Se  = 0.;

e=fem.elt(ne);
NBN=e.NBN;

% ne : numero de l element
% recuperer les poids et abscisses en fonction du type d elements
% polynomes de Lagrange associes a ses noeuds ainsi que leurs
% gradients
% chargement des polynomes de Lagrange pour triangles a 3 noeuds
if (e.TYP==2)
    [gauss]=polynomes_T3(fem,ne);

    NPI=gauss.NPI;

    detJ=gauss.detJ; % detJ(k)
    pds =gauss.pds;  % pds(k)
    x=gauss.x;       % x(k) : abscisse reelle du k-ieme point de Gauss
    y=gauss.y;       % y(k) : ordonnee reelle du k-ieme point de Gauss

    % Calcul de l'integrale elementaire par sommation de Gauss :
    %
    %      I_e = sum_k  f(x_k, y_k) * pds(k) * detJ(k)
    %
    % avec, pour chacune des 4 grandeurs a calculer :
    %      Se  <-> f(x,y) = 1
    %      Ix  <-> f(x,y) = x
    %      Iy  <-> f(x,y) = y
    %      Ir2 <-> f(x,y) = (x-fem.Xo)^2 + (y-fem.Yo)^2
    %
    % A COMPLETER : accumuler, pour chaque point de Gauss k=1..NPI,
    % la contribution de ce point dans Ix, Iy, Ir2 et Se.

    for k=1:NPI
        % A COMPLETER : Ix  = Ix  + ...
        
        % A COMPLETER : Iy  = Iy  + ...

        % A COMPLETER : Ir2 = Ir2 + ...

        % A COMPLETER : Se  = Se  + ...
    end
end

end
