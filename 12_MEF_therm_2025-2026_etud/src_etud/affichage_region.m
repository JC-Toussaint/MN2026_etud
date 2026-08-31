function [fem]=affichage_region(fem)

h=figure(1);
hold off;
set(h, 'Position',[0 350 500 400]);

NP=fem.NP;
NE=fem.NE;
NRG=fem.NRG;
noeud=fem.noeud;

for nrg=1:NRG
[r g b]=rgb(1-(nrg-1)/NRG);
reg(nrg).rgb=[r g b];
reg(nrg).iter=1;
reg(nrg).adj=sparse(NP, NP);
end

for ne=1:NE
    nrg=fem.elt(ne).NRG;
    typ=fem.elt(ne).TYP;

    iter=reg(nrg).iter;
    reg(nrg).lst(iter, :)=fem.elt(ne).ind;
    if (typ==1)
       i=fem.elt(ne).ind(1);
       j=fem.elt(ne).ind(2);
       reg(nrg).adj(i, j)=1;
    end   
    iter=iter+1;
    reg(nrg).iter=iter;
    reg(nrg).TYP=typ;

end

for i=1:NP
    x(i)=noeud(i).x;
    y(i)=noeud(i).y;
    z(i)=0;
end

xy=[x; y]';

for nrg=1:NRG
    if (reg(nrg).TYP==1)
       gplot2(reg(nrg).adj, xy, 'Color', reg(nrg).rgb, 'LineWidth',2);
    else   
       trisurf(reg(nrg).lst,x,y,z, 'FaceColor', reg(nrg).rgb)
       view(2)
       hold on;
    end
end

fem.reg=reg;
hold off
axis equal


function [Xout,Yout]=gplot2(A, xy, varargin)
%GPLOT Plot graph, as in "graph theory".
%   GPLOT(A,xy) plots the graph specified by A and xy. A graph, G, is
%   a set of nodes numbered from 1 to n, and a set of connections, or
%   edges, between them.  
%
%   In order to plot G, two matrices are needed. The adjacency matrix,
%   A, has a(i,j) nonzero if and only if node i is connected to node
%   j.  The coordinates array, xy, is an n-by-2 matrix with the
%   position for node i in the i-th row, xy(i,:) = [x(i) y(i)].  
%
%   [X,Y] = GPLOT(A,xy) returns the NaN-punctuated vectors
%   X and Y without actually generating a plot. These vectors
%   can be used to generate the plot at a later time if desired.
%   
%   See also SPY, TREEPLOT.

%   John Gilbert, 1991.
%   Modified 1-21-91, LS; 2-28-92, 6-16-92 CBM.
%   Copyright 1984-2002 The MathWorks, Inc. 
%   $Revision: 5.12 $  $Date: 2002/04/15 04:13:43 $
%   Revised by G. De Marco, 2006

[i,j] = find(A);
[ignore, p] = sort(max(i,j));
i = i(p);
j = j(p);

% Create a long, NaN-separated list of line segments,
% rather than individual segments.

X = [ xy(i,1) xy(j,1) repmat(NaN,size(i))]';
Y = [ xy(i,2) xy(j,2) repmat(NaN,size(i))]';
X = X(:);
Y = Y(:);
% Create the line properties string

if nargout==0
        h=plot(X, Y);
else
    Xout = X;
    Yout = Y;
end

if nargin>2
    for k=1:nargin-3
        s=varargin{k};
try
    if isnumeric(varargin{k+1})
       set(h,s,varargin{k+1})
    else
       set(h,s)
    end
catch
    end
    
    end
end
