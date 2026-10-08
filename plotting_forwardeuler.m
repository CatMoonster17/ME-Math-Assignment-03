function plotting_forwardeuler()
    t_span = [0, 2*pi];
    Xa = solution01(t_span(1));

    h1 = 0.1; %delta t
    [t_list1,X_list1,h_avg1, num_evals1] = forward_euler_fixed_step_integration(@rate_func01,t_span,Xa,h1);

    h2 = 0.25; %delta t
    [t_list2,X_list2,h_avg2, num_evals2] = forward_euler_fixed_step_integration(@rate_func01,t_span,Xa,h2);

    h3 = 0.45; %delta t
    [t_list3,X_list3,h_avg3, num_evals3] = forward_euler_fixed_step_integration(@rate_func01,t_span,Xa,h3);

    %Set up plotting analytical solution
    t_an = linspace(0, 2*pi, 1000);
    X_an = solution01(t_an);
    
    figure()
    axis equal
    title("Forward Euler Integration", "Interpreter", "latex", "FontSize", 17);
    xlabel("t(-)", "Interpreter", "latex", "FontSize", 13); ylabel("X(t)(-)", "Interpreter", "latex", "FontSize", 13);
    hold on;
    p1 = plot(t_list1, X_list1, 'r.-');
    p2 = plot(t_list2, X_list2, 'b.-');
    p3 = plot(t_list3, X_list3, 'g.-');
    p4 = plot(t_an, X_an, 'k-');

    legend([p4, p1, p2, p3], "Analytical solution", "h = " + h_avg1, "h = " + h_avg2, "h = " + h_avg3, "Location", "northeast", "Interpreter", "latex")
    hold off;
end
