% profil de l'inconnue sur un segment de droite defini par
% ses deux extremites a partir de la solution stockee dans
% la structure fem
% [tabval, err]=profil(fem, Npts, xi, yi, xf, yf);

function [tabval, err]=profil(fem, Npts, xi, yi, xf, yf)

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
%     if (err)
%        texte=['pick erreur en ' num2str(x) ' ' num2str(y)];
%        disp(texte);
%        err=1;
%     end;

    tabval(n)=val;

    r=sqrt(x*x+y*y);
    tabana(n)=u_ana(fem, r);
end;

subplot(2,1,1)
plot(s,real(tabval),'r.');
hold on
plot(s,real(tabana),'k');
title ('real(u) le long d un segment')
grid on
ylabel('real(u)')
              
subplot(2,1,2)
plot(s,imag(tabval),'b.');
hold on
plot(s,imag(tabana),'k');
title('imag(u) le long d un segment')
grid on
ylabel('imag(u)')



