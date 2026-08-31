    cond = (norm(x-x0) < eps) || (norm(x+x0) < eps); %--- until cond
    cond = ~cond;                                    % contraposee