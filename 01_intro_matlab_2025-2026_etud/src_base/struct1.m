% programme struct1
clear all

N=2;
for i=1:N
    s=['point ' num2str(i) ];
    disp(s);
    x=input('x :');
    y=input('y :');
    M(i).x=x;
    M(i).y=y;
end

for i=1:N
    s=['point' num2str(i) ]
    disp(M(i));
end
