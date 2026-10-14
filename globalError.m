function [e_list_for, e_list_back, e_list_exp, e_list_imp] = globalError(solution, rate_func_in, tspan, h_list)
    n = length(h_list);

    e_list_for = zeros(n,1);
    e_list_back = zeros(n,1);
    e_list_exp = zeros(n,1);
    e_list_imp = zeros(n,1);
    X0 = solution(tspan(1));

    for j = 1:length(h_list);
        h_now = h_list(j);
        [~, X_an1] = forward_euler_fixed_step_integration(rate_func_in,tspan,X0,h_now);
        [~, X_an2] = backward_euler_fixed_step_integration(rate_func_in,tspan,X0,h_now);
        [~, X_an3] = explicit_midpoint_fixed_step_integration(rate_func_in,tspan,X0,h_now);
        [~, X_an4] = implicit_midpoint_fixed_step_integration(rate_func_in,tspan,X0,h_now);

        X_real = solution(tspan(2));

        e_list_for(j) = norm(X_an1(end) - X_real);
        e_list_back(j) = norm(X_an2(end) - X_real);
        e_list_exp(j) = norm(X_an3(end) - X_real);
        e_list_imp(j) = norm(X_an4(end) - X_real);
    end
end