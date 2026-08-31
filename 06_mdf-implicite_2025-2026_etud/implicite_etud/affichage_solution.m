function affichage_solution(xi,yi,simul)

%
%  AFFICHAGE DU RESULTAT
%
% Representation graphique              

nummax=round(simul.tfinal/simul.deltat+1);

prompt = {'Nombre de courbes a representer ?'};
dlg_title = 'REPRESENTATION GRAPHIQUE';
num_lines= 1;
def     = {'11'};
valeur  = inputdlg(prompt,dlg_title,num_lines,def);
nbc = str2double(valeur);
if nbc<2
    nbc=2
end;

close all;
hold on

increment=round(nummax/(nbc-1));
it=0;
for num=1:increment:nummax
      [r g b]=rgb(it/nbc);
      it=it+1;
      pl(it)=plot(xi,yi(:,num),'color', [r g b]);
end

t=[0:increment:nummax-1]*simul.deltat;
legend(pl, num2str(t'));

type_schema = ' IMPLICITE ';

titre=strcat('Resolution d''EDP - Schema : ',type_schema,' - Pas de temps : ',num2str(simul.deltat));
title(titre)
xlabel('Position')
ylabel('Temperature')
grid on

hold off
