clear all
close all

prime=[2];
N= input('entier N : ');

for n=[2:N]
    flag = true;
    for p =prime
        if mod(n, p)==0
           flag=false;
           break 
        end
    end
    if flag
       prime=[prime n];
    end
    disp(prime)
end