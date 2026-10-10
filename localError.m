function e_list = localError(solution01, X_list, t_list, h)
    e_list = [];
    for i = 1:length(X_list)
        t = t_list(i);
        X_real = solution01(t);
        X_step = X_list(i);
        e = abs(X_step-X_real);
        e_list(i) = e;
    end   
end