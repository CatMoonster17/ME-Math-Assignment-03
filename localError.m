function e_list = localError(solution01, rate_func_in, tspan, X0, h_list)
    e_list = [];
    for j = 1:length(h_list);
        h_now = h_list(j);
        [t_list,X_list,h_avg, num_evals1] = forward_euler_fixed_step_integration(rate_func_in,tspan,X0,h_now);
        for i = 1:length(X_list)
            t = t_list(i);
            X_real = solution01(t);
            X_step = X_list(i);
            e = abs(X_step-X_real);
            e_list(j, i) = e;
        end
    end
end