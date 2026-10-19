function plottingpleasework()
    sol = @solution02;
    t_span = [0, 2*pi];
    num_iter = 100;
    rate_func = @rate_func02;

    X0 = sol(t_span(1));
    h_list = logspace(-3, -1, num_iter);
    log_h_list = log10(h_list)';
    iter = 0;
    
    clf
    figure(1)

    explicit_midpoint_error = zeros(num_iter,1);
    explicit_evals = zeros(num_iter,1);

    forward_evals = zeros(num_iter,1);
    forward_euler_error = zeros(num_iter, 1);

      for i = 1:num_iter
        h = h_list(i);
        [~, explicit_midpoint_list, ~, explicit_iter] = explicit_midpoint_fixed_step_integration(rate_func, t_span, X0, h);
        [~, forward_euler_list, ~, forward_iter] = forward_euler_fixed_step_integration(rate_func, t_span, X0, h);
        
        size(explicit_midpoint_list(end, :).');
        size(forward_euler_list(end, :).');
        % calculate error
        x_true = sol(t_span(end));
        x_true = x_true(:);
        size(x_true);
        explicit_midpoint_error(i) = norm(explicit_midpoint_list(end,:).' - x_true);
        forward_euler_error(i) = norm(forward_euler_list(end, :).' - x_true);

        % save iterations
        explicit_evals(i) = explicit_iter;
        forward_evals(i) = forward_iter;
        iter = iter+1;
      end

      % fun count p-values
        log_explicit_evals = log10(explicit_evals);
        log_explicit_midpoint_error = log10(explicit_midpoint_error);
        explicit_midpoint_eval_slope = polyfit(log_explicit_evals, log_explicit_midpoint_error, 1);
        
        log_forward_evals = log10(forward_evals);
        log_forward_euler_error = log10(forward_euler_error);
        forward_euler_eval_slope = polyfit(log_forward_evals, log_forward_euler_error, 1);

        %%%%%% FUN COUNT FIT LINE CODE
        % Explicit Midpoint fit line
        log_explicit_evals = log10(explicit_evals(1:90));
        log_explicit_midpoint_error = log10(explicit_midpoint_error(1:90));
        explicit_midpoint_slope = polyfit(log_explicit_evals, log_explicit_midpoint_error, 1);
        explicit_midpoint_fit = 10.^polyval(explicit_midpoint_slope, log_explicit_evals);
        explicit_midpoint_p = explicit_midpoint_slope(1)

        % Forward Euler fit line
        log_forward_evals = log10(forward_evals(1:90));
        log_forward_euler_error = log10(forward_euler_error(1:90));
        forward_euler_slope = polyfit(log_forward_evals, log_forward_euler_error, 1);
        forward_euler_fit = 10.^polyval(forward_euler_slope, log_forward_evals);
        forward_euler_p = forward_euler_slope(1)

        loglog(forward_evals(1:90), forward_euler_error(1:90), 'r.', 'Displayname',"Forward Euler", "MarkerSize", 17);
        hold on;
        loglog(forward_evals(1:90), forward_euler_fit, 'k-', 'Displayname',"Forw. Euler Fit");
        loglog(explicit_evals(1:90), explicit_midpoint_error(1:90), 'b.','Displayname',"Explicit Midpoint", "MarkerSize", 17);
        loglog(explicit_evals(1:90), explicit_midpoint_fit, 'k-','Displayname',"Exp. Mid. Fit");

        title('Global Trunction Error vs. Num Evals (explicit Methods)', 'Interpreter', 'Latex', 'FontSize', 17);
        xlabel('Num evals, $n (-)$', 'Interpreter', 'Latex', 'FontSize', 13);
        ylabel('Global Truncation Error, $ \epsilon (-)$', 'Interpreter', 'Latex', 'FontSize', 13);
        set(gca, 'XScale', 'log'); set(gca,'YScale', 'log');
        legend("Forward Euler", "Forward Euler Fit", "Explicit Midpoint", "Explicit Midpoint Fit", "Location", "Southeast", "Interpreter", "Latex")
        hold off;

        myfig = gcf(); %set myfig to the current figure
    exportgraphics(myfig , 'globalExplicitNumEvals.png', 'Resolution', 600); %saves plot to plot_name at high resolution

    figure();
    log_explicit_midpoint_error = log10(explicit_midpoint_error);
            explicit_midpoint_step_slope = polyfit(log_h_list, log_explicit_midpoint_error, 1);
            explicit_midpoint_fit = 10.^polyval(explicit_midpoint_step_slope, log_h_list);
            explicit_midpoint_p = explicit_midpoint_step_slope(1)

            log_forward_euler_error = log10(forward_euler_error);
            forward_euler_step_slope = polyfit(log_h_list, log_forward_euler_error, 1);
            forward_euler_fit = 10.^polyval(forward_euler_step_slope, log_h_list);
            forward_euler_p = forward_euler_step_slope(1)
            
    
            loglog(h_list(1:90), forward_euler_error(1:90), 'g.', 'Displayname',"Forward Euler", "MarkerSize", 17);
            hold on;
            loglog(h_list(1:90), forward_euler_fit(1:90), 'k-', 'Displayname',"Forw. Euler Fit");
            loglog(h_list(1:90), explicit_midpoint_error(1:90), 'm.', 'Displayname',"Explicit Midpoint", "MarkerSize", 17);
            loglog(h_list(1:90), explicit_midpoint_fit(1:90), 'k-', 'Displayname',"Exp. Mid. Fit");
            
             title('Global Trunction Error vs. Step Size (explicit Methods)', 'Interpreter', 'Latex', 'FontSize', 17);
        xlabel('Time step, $h (-)$', 'Interpreter', 'Latex', 'FontSize', 13);
        ylabel('Global Truncation Error, $ \epsilon (-)$', 'Interpreter', 'Latex', 'FontSize', 13);
        set(gca, 'XScale', 'log'); set(gca,'YScale', 'log');
        legend("Forward Euler", "Forward Euler Fit", "Explicit Midpoint", "Explicit Midpoint Fit", "Location", "Southeast", "Interpreter", "Latex")
        hold off;

        myfig = gcf(); %set myfig to the current figure
    exportgraphics(myfig , 'globalExplicitStepSize.png', 'Resolution', 600); %saves plot to plot_name at high resolution
end