% ------------
%  Exercice 9
% ------------

fid=fopen('note.txt','r');
x=fscanf(fid,'%d %d',[2 inf]);

histo(x)

fclose(fid);
