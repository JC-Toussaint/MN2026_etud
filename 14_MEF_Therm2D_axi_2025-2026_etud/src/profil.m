% profil de l'inconnue sur un segment de droite defini par
% ses deux extremites a partir de la solution stockee dans
% la structure fem
% [tabval, err]=profil(fem, Npts, xi, yi, xf, yf);

function [tabval, err]=profil(fem, Npts, xi, yi, xf, yf)

h=figure(4);
hold off;
set(h, 'Position',[600 50 500 400]);

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
%     if (err)
%        texte=['pick erreur en ' num2str(x) ' ' num2str(y)];
%        disp(texte);
%        err=1;
%     end;

    tabval(n)=val;
    tabgradx(n)=grad_val_x;
    tabgrady(n)=grad_val_y;
end;

subplot(3,1,1)
plot(s,tabval,'g');
str=['T sur le segment (' num2str(xi) '; ' num2str(yf) ') -> (' num2str(xf) ';' num2str(yf) ')'];
title(str);
grid on
ylabel('phi')
              
subplot(3,1,2)
plot(s,tabgradx,'r');
str=['dT/dx sur le segment (' num2str(xi) '; ' num2str(yf) ') -> (' num2str(xf) ';' num2str(yf) ')'];
title(str);
grid on
ylabel('dphi/dx')

subplot(3,1,3)
plot(s,tabgrady,'b');
str=['dT/dy sur le segment (' num2str(xi) '; ' num2str(yf) ') -> (' num2str(xf) ';' num2str(yf) ')'];
title(str);
grid on
xlabel('abscisse curviligne')
ylabel('dphi/dy')

