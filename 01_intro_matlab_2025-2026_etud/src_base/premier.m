clc        % clear command window
close all  % close all graphic windows

reply = input('entier : ','s'); % saisie
N=str2num(reply);  % transf chaine en nombre

Lp=[2]; % 2 le seul nombre premier pair

for n=3:2:N % impairs
    flag=true;
    for p=Lp
        if ~mod(n, p)
            flag=false;
            break;
        end;
    end;
    if flag
        Lp=[Lp, n];
    end;
end;

Lp
