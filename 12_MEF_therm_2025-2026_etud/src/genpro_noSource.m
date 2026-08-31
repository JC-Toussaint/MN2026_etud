% mailleur simpliste + affectation proprietes physiques
% pour l'equation de la chaleur statique en 2D

clc
clear all
close all

disp("Maillage d'une grille de taille NxN");
N=input('N=');

xoffset = 0.5;
yoffset = 0.5;

num=0;
j=1;
for i=1:N
    num=num+1;
    x(num)=(i-1)/N-xoffset;
    y(num)=(j-1)/N-yoffset;
end

i=N+1;
for j=1:N
    num=num+1;
    x(num)=(i-1)/N-xoffset;
    y(num)=(j-1)/N-yoffset;
end

j=N+1;
for i=N+1:-1:2
    num=num+1;
    x(num)=(i-1)/N-xoffset;
    y(num)=(j-1)/N-yoffset;
end

i=1;
for j=N+1:-1:2
    num=num+1;
    x(num)=(i-1)/N-xoffset;
    y(num)=(j-1)/N-yoffset;
end

for i=2:N
    for j=2:N
        num=num+1;
        x(num)=(i-1)/N-xoffset;
        y(num)=(j-1)/N-yoffset;
    end
end

tri=delaunay(x,y);
%triplot(tri, x, y);

NE=length(tri);
NRG=1; %nb de regions surfaciques
for ie=1:NE
    ind=tri(ie,:);
    xe=x(ind);
    ye=y(ind);
    xg=mean(xe);
    yg=mean(ye);
    surf2=(xe(2)-xe(1))*(ye(3)-ye(1))-(ye(2)-ye(1))*(xe(3)-xe(1));
    if (surf2<0) % mal oriente => echange des noeuds 2 et 3
       n2=tri(ie,2); 
       n3=tri(ie,3);
       tri(ie,3)=n2;
       tri(ie,2)=n3;
       fprintf(1, 'echange des noeuds %d %d dans  %d\n', n2, n3, ie);
    end    
    reg(ie)=1;
end   

filename = ['square' num2str(num) '.pro'];   
fid=fopen(filename, 'w');
fprintf(fid, '%s\n','NOEUDS');
fprintf(fid, '%d\n',num);
n=1:num;
output=[n; x; y];
fprintf(fid, '%5d%15.5f%15.5f\n', output);
fprintf(fid,'\n');
fprintf(fid, '%s\n','ELEMENTS_SURFACIQUES_&_LINEIQUES');
fprintf(fid, '%5d\n', NE+4*N); %4 regions lineiques de N elements

%elements surfaciques
output=[2*ones(NE,1)'; 3*ones(NE,1)'; reg; tri'];
fprintf(fid, '%5d%5d%5d%8d%8d%8d\n', output);
%elements lineiques
%1ere region lineique en y=0
NRG=NRG+1;
reg=NRG*ones(N,1);
lin=[1:N; 2:N+1];
output=[ones(N,1)'; 2*ones(N,1)'; reg'; lin];
fprintf(fid, '%5d%5d%5d%8d%8d\n', output);

%2eme region lineique en x=1
NRG=NRG+1;
reg=NRG*ones(N,1);
lin=[N+1:2*N; N+2:2*N+1];
output=[ones(N,1)'; 2*ones(N,1)'; reg'; lin];
fprintf(fid, '%5d%5d%5d%8d%8d\n', output);

%3eme region lineique en y=1
NRG=NRG+1;
reg=NRG*ones(N,1);
lin=[2*N+1:3*N; 2*N+2:3*N+1];
output=[ones(N,1)'; 2*ones(N,1)'; reg'; lin];
fprintf(fid, '%5d%5d%5d%8d%8d\n', output);

%4eme region lineique en x=0
NRG=NRG+1;
reg=NRG*ones(N,1);
lin=[3*N+1:4*N; 3*N+2:4*N+1];
lin(2,N)=1; %couture
output=[ones(N,1)'; 2*ones(N,1)'; reg'; lin];
fprintf(fid, '%5d%5d%5d%8d%8d\n', output);
fprintf(fid,'\n');


fprintf(fid, '%s\n','AFFECTATION_PROPRIETES_PHYSIQUES');
fprintf(fid, '%5d\n', NRG);
kth=zeros(NRG,1);
qth=zeros(NRG,1);
hcv=zeros(NRG,1);
Ta =zeros(NRG,1);

%conductivite & source dans les regions surfaciques
kth=[5.0 0.0 0.0 0.0 0.0];
qth=[0.0 0.0 0.0 0.0 0.0];

%echange dans les regions lineiques
hcv = [0.0 10.0 10.0 10.0 10.0];
Ta =  [0.0 350  350  350  350];

output=[kth; qth; hcv; Ta];
fprintf(fid, '%15.5f%15.5f%15.5f%15.5f\n', output);
fprintf(fid,'\n');

fprintf(fid, '%s\n','CONDITIONS_AUX_LIMITES');
%fprintf(fid, '%5d\n', 0);

fprintf(fid, '%5d\n', 2*(N+1));
% Dirichlet T=300 en y=0
output=[1:N+1; 300*ones(N+1,1)'];
fprintf(fid, '%8d%15.5f\n', output);
% Dirichlet T=500 en y=1
output=[2*N+1:3*N+1; 500*ones(N+1,1)'];
fprintf(fid, '%8d%15.5f\n', output);

fclose(fid);

% lecture maillage + affectations par regions
[fem, err]=lecture_probleme(filename);
affichage_region(fem);