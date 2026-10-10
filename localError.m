function [e_list_eul, e_list_mid] = localError(solution, rate_func_in, h_list)
    e_list_eul = zeros(100,1);
    e_list_mid = zeros(100,1);
    t_ref = 0.439;
    X0 = solution(t_ref);

    for j = 1:length(h_list);
        h_now = h_list(j);
        X_an1 = forward_euler_step(rate_func_in,t_ref,X0,h_now);
        X_an2 = explicit_midpoint_step(rate_func_in,t_ref,X0,h_now);
        X_real = solution(t_ref + h_now);
        e_list_eul(j) = abs(X_an1 - X_real);
        e_list_mid(j) = abs(X_an2 - X_real);
    end
end