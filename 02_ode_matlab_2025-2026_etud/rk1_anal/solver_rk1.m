function solver_rk1
clc       % efface la fenetre de commande
clear all % efface la memoire
close all % ferme les fenetres graphiques

param=[0 1.5 0.1];
[T,Y] = rk1(@anal,param,[1 0]);

% Create figure
figure1 = figure('Color',[1 1 1]);

% Create axes
axes1 = axes('Parent',figure1,'FontWeight','bold','FontSize',16);
xlim(axes1,[0 1.6]);
box(axes1,'on');
grid(axes1,'on');
hold(axes1,'all');

plot(T,Y(:,1),'-o', 'LineWidth',2)
hold on

y=1./(1.+T)
plot(T,y,'-r', 'LineWidth',2)
title('Methode RK1','FontSize',18);
grid on
end

function dY_dt = anal(t,Y)
dY_dt = zeros(1,2);    % vecteur ligne

% changement de variable 
% pour garder les notations de l'equation
y=Y(1);

% ecriture de l'equation telle quelle
dy_dt = -y*y;

% changement de variable pour 
% se conformer au vecteur de sortie dY_dt
dY_dt(1)=dy_dt;

end