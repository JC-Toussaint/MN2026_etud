% repeat until en matlab
iter=0;

cond=true; %-------------- repeat
while cond
    iter = iter+1
    cond =(iter==10); %--- until cond
    cond = ~cond;     %--- contraposee
end;       

