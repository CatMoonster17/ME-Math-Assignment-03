function plotting_forwardeuler()
    h = 0.1; %delta t
    t_span = [1, 10];
    Xa = solution01(t_span(1));
    [t_list,X_list,h_avg, num_evals] = forward_euler_fixed_step_integration(@rate_func01,t_span,Xa,h);
    
    figure()
    axis equal
    title("Forward Euler Integration", "Interpreter", "latex", "FontSize", 17);
    xlabel("t(-)", "Interpreter", "latex", "FontSize", 13); ylabel("X(t)(-)", "Interpreter", "latex", "FontSize", 13);
    hold on;
    plot(t_list, X_list);
    hold off;
end
