% exo 7
clear

load fichier.txt
fichier

subplot(2,1,1)
plot(fichier(:,1),fichier(:,2),'r-o')
grid on

%Variante avec fopen et fscanf :
fid=fopen('fichier.txt');
a=fscanf(fid,'%f %f %f',[3 inf]);
fclose(fid);

subplot(2,1,2)
plot(a(1,:),a(3,:),'g-*')
grid on

% Sauvegarde
fid=fopen('sauvegarde.txt','w') ;
fprintf(fid,'%f %f %f\n',fichier);
fclose(fid);

