function globalerrorplotting()
    funcnum = 1; 
    g = 0;

    if funcnum == 1
        func = @rate_func01;
        sol = @solution01;
        g = 90;
    elseif funcnum == 2
        func = @rate_func02;
        sol = @solution02;
        g = 75;
    end

    h_list = logspace(-3, 1, 100);
    t_span = [0, 2*pi];
    [e_list_for, e_list_back, e_list_exp, e_list_imp, for_evals, back_evals, exp_evals, imp_evals] = globalError(sol, func, t_span, h_list, funcnum);
    

    %Get log values
    h_log = log10(h_list)';
    e_log_for = log10(e_list_for);
    e_log_back = log10(e_list_back);
    e_log_exp = log10(e_list_exp);
    e_log_imp = log10(e_list_imp);

    poly_for = polyfit(h_log(1:g), e_log_for(1:g), 1);
    yfit_for = 10.^polyval(poly_for, h_log);

    poly_back = polyfit(h_log(1:g), e_log_back(1:g), 1);
    yfit_back = 10.^polyval(poly_back, h_log);

    poly_exp = polyfit(h_log(1:g), e_log_exp(1:g), 1);
    yfit_exp = 10.^polyval(poly_exp, h_log);

    poly_imp = polyfit(h_log(1:g), e_log_imp(1:g), 1);
    yfit_imp = 10.^polyval(poly_imp, h_log);

    p_for = poly_for(1) %Found p value!
    p_back = poly_back(1) %Found p value!
    p_exp = poly_exp(1) %Found p value!
    p_imp = poly_imp(1) %Found p value!

    figure()
    hold on;
    loglog(10.^h_log(1:g), yfit_for(1:g), 'k--');
    loglog(h_list(1:g), e_list_for(1:g), 'r.');
    title('Global Trunction Error (Forward Euler)', 'Interpreter', 'Latex', 'FontSize', 17);
    xlabel('h(-)', 'Interpreter', 'Latex', 'FontSize', 13);
    ylabel('Error(-)', 'Interpreter', 'Latex', 'FontSize', 13);
    set(gca, 'XScale', 'log'); set(gca,'YScale', 'log');
    hold off;

    figure()
    hold on;
    loglog(10.^h_log(1:g), yfit_back(1:g), 'k--');
    loglog(h_list(1:g), e_list_back(1:g), 'r.');
    title('Global Trunction Error (Backward Euler)', 'Interpreter', 'Latex', 'FontSize', 17);
    xlabel('h(-)', 'Interpreter', 'Latex', 'FontSize', 13);
    ylabel('Error(-)', 'Interpreter', 'Latex', 'FontSize', 13);
    set(gca, 'XScale', 'log'); set(gca,'YScale', 'log');
    hold off;

    figure()
    hold on;
    loglog(10.^h_log(1:g), yfit_imp(1:g), 'k--');
    loglog(h_list(1:g), e_list_imp(1:g), 'r.');
    title('Global Trunction Error (Implicit Midpoint)', 'Interpreter', 'Latex', 'FontSize', 17);
    xlabel('h(-)', 'Interpreter', 'Latex', 'FontSize', 13);
    ylabel('Error(-)', 'Interpreter', 'Latex', 'FontSize', 13);
    set(gca, 'XScale', 'log'); set(gca,'YScale', 'log');
    hold off;

    figure()
    hold on;
    loglog(10.^h_log(1:g), yfit_exp(1:g), 'k--');
    loglog(h_list(1:g), e_list_exp(1:g), 'r.');
    title('Global Trunction Error (Explicit Midpoint)', 'Interpreter', 'Latex', 'FontSize', 17);
    xlabel('h(-)', 'Interpreter', 'Latex', 'FontSize', 13);
    ylabel('Error(-)', 'Interpreter', 'Latex', 'FontSize', 13);
    set(gca, 'XScale', 'log'); set(gca,'YScale', 'log');
    hold off;
    
    figure()
    hold on;
    loglog(for_evals, e_list_for, 'r.-');
    title('Global Trunction Error v. Num Evals (Forwards Euler)', 'Interpreter', 'Latex', 'FontSize', 17);
    xlabel('Number of Evals', 'Interpreter', 'Latex', 'FontSize', 13);
    ylabel('Error(-)', 'Interpreter', 'Latex', 'FontSize', 13);
    set(gca, 'XScale', 'log'); set(gca,'YScale', 'log');
    hold off;

    figure()
    hold on;
    loglog(back_evals, e_list_back, 'r.-');
    title('Global Trunction Error v. Num Evals (Backwards Euler)', 'Interpreter', 'Latex', 'FontSize', 17);
    xlabel('Number of Evals', 'Interpreter', 'Latex', 'FontSize', 13);
    ylabel('Error(-)', 'Interpreter', 'Latex', 'FontSize', 13);
    set(gca, 'XScale', 'log'); set(gca,'YScale', 'log');
    hold off;

    figure()
    hold on;
    loglog(exp_evals, e_list_exp, 'r.-');
    title('Global Trunction Error v. Num Evals (Explicit Midpoint)', 'Interpreter', 'Latex', 'FontSize', 17);
    xlabel('Number of Evals', 'Interpreter', 'Latex', 'FontSize', 13);
    ylabel('Error(-)', 'Interpreter', 'Latex', 'FontSize', 13);
    set(gca, 'XScale', 'log'); set(gca,'YScale', 'log');
    hold off;

    figure()
    hold on;
    loglog(imp_evals, e_list_imp, 'r.-');
    title('Global Trunction Error v. Num Evals (Implicit Midpoint)', 'Interpreter', 'Latex', 'FontSize', 17);
    xlabel('Number of Evals', 'Interpreter', 'Latex', 'FontSize', 13);
    ylabel('Error(-)', 'Interpreter', 'Latex', 'FontSize', 13);
    set(gca, 'XScale', 'log'); set(gca,'YScale', 'log');
    hold off;

    for_num_evals = for_evals(end);
    back_num_evals = back_evals(end);
    exp_num_evals = exp_evals(end);
    imp_num_evals = imp_evals(end);
end