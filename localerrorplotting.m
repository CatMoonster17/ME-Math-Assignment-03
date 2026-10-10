function localerrorplotting()
    h_list = logspace(-5, 1, 100);
    [e_list_eul, e_list_mid] = localError(@solution01, @rate_func01, h_list);
    
    %Get log values
    h_log = log10(h_list);
    e_log_eul = log10(e_list_eul);
    e_log_mid = log10(e_list_mid);

    poly_eul = polyfit(h_log, e_log_eul, 1);
    yfit_eul = 10.^polyval(poly_eul, h_log);

    poly_mid = polyfit(h_log, e_log_mid, 1);
    yfit_mid = 10.^polyval(poly_mid, h_log);

    p_eul = poly_eul(1) %Found p value!
    p_mid = poly_mid(1) %Found p value!

    figure()
    hold on;
    loglog(10.^h_log, yfit_eul, 'k--');
    loglog(h_list, e_list_eul, 'r.');
    title('Local Trunction Error (Forward Euler)', 'Interpreter', 'Latex', 'FontSize', 17);
    xlabel('h(-)', 'Interpreter', 'Latex', 'FontSize', 13);
    ylabel('Error(-)', 'Interpreter', 'Latex', 'FontSize', 13);
    set(gca, 'XScale', 'log'); set(gca,'YScale', 'log');
    hold off;

    figure()
    hold on;
    loglog(10.^h_log, yfit_mid, 'k--');
    loglog(h_list, e_list_mid, 'r.');
    title('Local Trunction Error (Explicit Midpoint)', 'Interpreter', 'Latex', 'FontSize', 17);
    xlabel('h(-)', 'Interpreter', 'Latex', 'FontSize', 13);
    ylabel('Error(-)', 'Interpreter', 'Latex', 'FontSize', 13);
    set(gca, 'XScale', 'log'); set(gca,'YScale', 'log');
    hold off;
end