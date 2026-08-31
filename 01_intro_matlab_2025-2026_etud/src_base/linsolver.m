function linsolver
A=[1 2 3;1 2 3;4 -3 1]
b=[1 -2 3]'

[x, ier]=resolution(A, b)
if (ier) 
   error('Pb resolution');
end;   

function [x, res]=resolution(A, b)

if (det(A)==0)

	res=1;
	x=0;
else
	res=0;
	x=A\b;
end
