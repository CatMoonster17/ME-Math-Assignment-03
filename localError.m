function e_list = localError(solution, rate_func_in, h_list)
    e_list = zeros(100,1);
    t_ref = 0.439;
    X0 = solution(t_ref);
    for j = 1:length(h_list);
        h_now = h_list(j);
        X_an = forward_euler_step(rate_func_in,t_ref,X0,h_now);
        X_real = solution(t_ref + h_now);
        e_list(j) = abs(X_an - X_real);
    end
end