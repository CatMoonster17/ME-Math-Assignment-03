function localerrorplotting()
    h_list = logspace(-5, -1, 50);
    [e_list_for, e_list_back, e_list_exp, e_list_imp] = localError(@solution02, @rate_func02, h_list);
    
    %Get log values
    h_log = log10(h_list);
    e_log_for = log10(e_list_for);
    e_log_back = log10(e_list_back);
    e_log_exp = log10(e_list_exp);
    e_log_imp = log10(e_list_imp);

    poly_for = polyfit(h_log, e_log_for, 1);
    yfit_for = 10.^polyval(poly_for, h_log);

    poly_back = polyfit(h_log, e_log_back, 1);
    yfit_back = 10.^polyval(poly_back, h_log);

    poly_exp = polyfit(h_log, e_log_exp, 1);
    yfit_exp = 10.^polyval(poly_exp, h_log);

    poly_imp = polyfit(h_log, e_log_imp, 1);
    yfit_imp = 10.^polyval(poly_imp, h_log);

    p_for = poly_for(1) %Found p value!
    p_back = poly_back(1) %Found p value!
    p_exp = poly_exp(1) %Found p value!
    p_imp = poly_imp(1) %Found p value!

    figure()
    hold on;
    a1 = loglog(10.^h_log, yfit_for, 'k-');
    a2 = loglog(h_list, e_list_for, 'r.','MarkerSize', 15);
    % title('Local Trunction Error vs. h Value (Explicit Methods)', 'Interpreter', 'Latex', 'FontSize', 17);
    % xlabel('h(-)', 'Interpreter', 'Latex', 'FontSize', 13);
    % ylabel('Error(-)', 'Interpreter', 'Latex', 'FontSize', 13);
    % legend()
    % set(gca, 'XScale', 'log'); set(gca,'YScale', 'log');
    % hold off;
    % 
    % figure()
    % hold on;
    % loglog(10.^h_log, yfit_back, 'k--');
    %a2 = loglog(h_list, e_list_back, 'b.','MarkerSize', 10);
    % title('Local Trunction Error (Backward Euler)', 'Interpreter', 'Latex', 'FontSize', 17);
    % xlabel('h(-)', 'Interpreter', 'Latex', 'FontSize', 13);
    % ylabel('Error(-)', 'Interpreter', 'Latex', 'FontSize', 13);
    % set(gca, 'XScale', 'log'); set(gca,'YScale', 'log');
    % hold off;
    % 
    % figure()
    %hold on;
    % loglog(10.^h_log, yfit_imp, 'k--');
    %b1 = loglog(h_list, e_list_imp, 'g.','MarkerSize', 15);
    % title('Local Trunction Error (Implicit Midpoint)', 'Interpreter', 'Latex', 'FontSize', 17);
    % xlabel('h(-)', 'Interpreter', 'Latex', 'FontSize', 13);
    % ylabel('Error(-)', 'Interpreter', 'Latex', 'FontSize', 13);
    % set(gca, 'XScale', 'log'); set(gca,'YScale', 'log');
    % hold off;
    % 
    % figure()
    % hold on;
    b1 = loglog(10.^h_log, yfit_exp, 'k-');
    b2 = loglog(h_list, e_list_exp, 'm.','MarkerSize', 10);
    title('Local Trunction Error vs. Time Step Size', 'Interpreter', 'Latex', 'FontSize', 17);
    xlabel('Time Step, $h (-)$', 'Interpreter', 'Latex', 'FontSize', 13);
    ylabel('Local Truncation Error, $\epsilon (-)$', 'Interpreter', 'Latex', 'FontSize', 13);
    %legend([a1, a2, b1, b2], "Forward Euler", "Backward Euler", "Explicit Midpoint", "Implicit Midpoint", "Location", "NorthWest")
    legend([a1, a2, b1, b2], "Forward Euler", "Forward Euler Fit", "Explicit Midpoint", "Explicit Midpoint Fit", "Location", "NorthWest")
    set(gca, 'XScale', 'log'); set(gca,'YScale', 'log');
    hold off;

    myfig = gcf(); %set myfig to the current figure
    exportgraphics(myfig , 'localExplicit.png', 'Resolution', 600); %saves plot to plot_name at high resolution
end