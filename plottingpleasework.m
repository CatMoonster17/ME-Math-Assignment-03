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

        loglog(explicit_evals(1:90), explicit_midpoint_fit, '-', 'Linewidth', 2, 'Color', [0.5 1 0.5], 'Displayname',"Exp. Mid. Fit");
        hold on;
        loglog(forward_evals(1:90), forward_euler_fit, '-', 'Linewidth', 2, 'Color', [1 0.5 0.5], 'Displayname',"Forw. Euler Fit");
end