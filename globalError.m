function [e_list_for, e_list_back, e_list_exp, e_list_imp, for_evals, back_evals, exp_evals, imp_evals] = globalError(solution, rate_func_in, tspan, h_list, num)
    n = length(h_list);

    e_list_for = zeros(n,1);
    e_list_back = zeros(n,1);
    e_list_exp = zeros(n,1);
    e_list_imp = zeros(n,1);
    X0 = solution(tspan(1));

    for_evals = zeros(n,1);
    back_evals = zeros(n,1);
    exp_evals = zeros(n,1);
    imp_evals = zeros(n,1);

    for j = 1:length(h_list);
        h_now = h_list(j);
        [~, X_an1, ~, iter1] = forward_euler_fixed_step_integration(rate_func_in,tspan,X0,h_now);
        [~, X_an2, ~, iter2] = backward_euler_fixed_step_integration(rate_func_in,tspan,X0,h_now);
        [~, X_an3, ~, iter3] = explicit_midpoint_fixed_step_integration(rate_func_in,tspan,X0,h_now);
        [~, X_an4, ~, iter4] = implicit_midpoint_fixed_step_integration(rate_func_in,tspan,X0,h_now);

        X_real = solution(tspan(2));

        e_list_for(j) = norm(X_an1(:, end) - X_real);
        e_list_back(j) = norm(X_an2(:, end) - X_real);
        if num == 1
            e_list_exp(j) = norm(X_an3(end) - X_real);
        elseif num ==2
            e_list_exp(j) = norm(X_an3(:, end).' - X_real);
        end
        e_list_imp(j) = norm(X_an4(:, end) - X_real);

        for_evals(j) = iter1;
        back_evals(j) = iter2;
        exp_evals(j) = iter3;
        imp_evals(j) = iter4;
    end
end