% Isovaleurs 

clc
close all

[phi,tet]=meshgrid(0:0.02:2*pi,0:0.01:pi);

e=sin(tet).^4.*cos(2*phi);

% isovaleurs fixees
v=-1:0.2:1;

colormap([0 0 0])
[c,h]=contour(phi,tet,e,v);

set(h,'ShowText','on','TextStep',get(h,'LevelStep')*2);

figure
colormap(jet)
[c,h]=contour(phi,tet,e,v);
set(h,'ShowText','on','TextStep',get(h,'LevelStep')*2);

figure 
colormap(jet)
h=surf(phi,tet,e);
shading interp



