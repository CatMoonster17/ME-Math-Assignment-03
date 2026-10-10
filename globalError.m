function [e_list_eul, e_list_mid] = globalError(solution, rate_func_in, tspan, h_list)
    e_list_eul = zeros(100,1);
    e_list_mid = zeros(100,1);
    X0 = solution(tspan(1));

    for j = 1:length(h_list);
        h_now = h_list(j);
        [~, X_an1] = forward_euler_fixed_step_integration(rate_func_in,tspan,X0,h_now);
        [~, X_an2] = explicit_midpoint_fixed_step_integration(rate_func_in,tspan,X0,h_now);
        X_real = solution(tspan(2));
        e_list_eul(j) = abs(X_an1(end) - X_real);
        e_list_mid(j) = abs(X_an2(end) - X_real);
    end
end