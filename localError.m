function [e_list_for, e_list_back, e_list_exp, e_list_imp] = localError(solution, rate_func_in, h_list)
    n = length(h_list);

    e_list_for = zeros(n,1);
    e_list_back = zeros(n,1);
    e_list_exp = zeros(n,1);
    e_list_imp = zeros(n,1);
    t_ref = 0.439;
    X0 = solution(t_ref);

    for j = 1:length(h_list);
        h_now = h_list(j);
        X_an1 = forward_euler_step(rate_func_in,t_ref,X0,h_now);
        X_an2 = backward_euler_step(rate_func_in, t_ref, X0, h_now);
        X_an3 = explicit_midpoint_step(rate_func_in,t_ref,X0,h_now);
        X_an4 = implicit_midpoint_step(rate_func_in, t_ref, X0, h_now);

        X_real = solution(t_ref + h_now);
        e_list_for(j) = norm(X_an1 - X_real);
        e_list_back(j) = norm(X_an2 - X_real);
        e_list_exp(j) = norm(X_an3 - X_real);
        e_list_imp(j) = norm(X_an4 - X_real);
    end
end