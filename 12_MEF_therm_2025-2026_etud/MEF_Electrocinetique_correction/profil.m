% profil de l'inconnue sur un segment de droite defini par
% ses deux extremites a partir de la solution stockee dans
% la structure fem
% [tabval, err]=profil(fem, Npts, xi, yi, xf, yf);

function [tabval, err]=profil(fem, Npts, xi, yi, xf, yf);

h=figure(4);
hold off;
set(h, 'Position',[550 50 500 400]);

if (Npts<=0)
   err=1;
   return;
end;

dx=(xf-xi)/(Npts-1);
dy=(yf-yi)/(Npts-1);
ds=sqrt(dx*dx+dy*dy);

%abscisse curviligne
s=[0:Npts-1]*ds;
for n=1:Npts
    x=xi+dx*(n-1);
    y=yi+dy*(n-1);
    
    [val,grad_val_x,grad_val_y, err]=pick(fem, x, y);
    if (err)
       texte='pick erreur en '+num2str(x)+' '+num2str(y);
       disp(texte);
       err=1;
    end;

    tabval(n)=val;
    tabgradx(n)=grad_val_x;
    tabgrady(n)=grad_val_y;
end;

subplot(3,1,1)
plot(s,tabval,'g');
title ('V le long d un segment')
grid on
ylabel('V')
              
subplot(3,1,2)
plot(s,tabgradx,'r');
title('dV/dx le long d un segment')
grid on
ylabel('dV/dx')

subplot(3,1,3)
plot(s,tabgrady,'b');
title('dV/dy le long d un segment')
grid on
xlabel('abscisse curviligne')
ylabel('dV/dy')

