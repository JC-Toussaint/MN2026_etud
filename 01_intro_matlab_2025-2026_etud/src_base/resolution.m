% Resolution de systeme
function [X, err]=resolution(A,b)


err=0;
X=A\b;
error(lastwarn)

end

