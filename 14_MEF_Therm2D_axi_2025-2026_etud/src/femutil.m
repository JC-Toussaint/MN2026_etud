function [fem]=femutil(fem)
NP=fem.NP;
NE=fem.NE;

xmin=Inf;
xmax=-xmin;
ymin=Inf;
ymax=-ymin;

for np=1:NP
    if fem.noeud(np).x<xmin; xmin=fem.noeud(np).x; end;
    if fem.noeud(np).x>xmax; xmax=fem.noeud(np).x; end; 
    if fem.noeud(np).y<ymin; ymin=fem.noeud(np).y; end;
    if fem.noeud(np).y>ymax; ymax=fem.noeud(np).y; end; 
end;

fem.xmin=xmin;
fem.xmax=xmax;
fem.ymin=ymin;
fem.ymax=ymax;

        
        
        
        
