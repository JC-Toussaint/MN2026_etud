% [r g b]=rgb(x)
% x reel dans [0, 1]
% fonction retourne les composantes rgb de la colormap jet

function [r g b]=rgb(x)
r=0;
g=0;
b=0;
if x>=0 & x<=0.25
    b=4*x;
else if x>0.25 & x<=0.5
        g=4*(x-0.25);
        b=1;
    else if x>0.5 & x<=0.75
        r=4*(x-0.5);
        g=1;
        b=1-4*(x-0.5);
        else if x>0.75 & x<=1
            r=1;
            g=1-4*(x-0.75);
            b=0;   
            end;
        end;
    end;
end;    
