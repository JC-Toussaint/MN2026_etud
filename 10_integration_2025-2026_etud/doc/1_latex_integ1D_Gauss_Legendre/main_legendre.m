clc
clear all
close all

u=linspace(-1, 1, 101);
y=Pl(u, 3);
plot(u, y, 'r')
hold on
plot(u, zeros(size(u)), 'b')
grid on


function [val]=Pl(u, n)
switch n
    case 0
        val = ones(size(u));  
    case 1
        val = u;
    otherwise
        val = ((2*n-1)*u.*Pl(u, n-1)-(n-1)*Pl(u, n-2))/n;
end

end