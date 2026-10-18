clear;
clc;
close all;

% Time interval and target step size
tspan = [0 20];
h_ref = 0.45;
X0 = 1;

% Analytical solution
t_exact = linspace(tspan(1),tspan(2),1000);
x_exact = solution01(t_exact);

% Forward Euler
[t_FE,X_FE,h_FE,eval_FE] = ...
   fixed_step_integration(@rate_func01, @forward_euler_step, tspan,X0, h_ref);

% Backward Euler
[t_BE,X_BE,h_BE,eval_BE] = ...
   fixed_step_integration(@rate_func01, @backward_euler_step, tspan,X0,h_ref);

% Explicit Midpoint
[t_EM,X_EM,h_EM,eval_EM] = ...
    fixed_step_integration(@rate_func01, @explicit_midpoint_step, tspan,X0,h_ref);

% Implicit Midpoint
[t_IM,X_IM,h_IM,eval_IM] = ...
    fixed_step_integration(@rate_func01, @implicit_midpoint_step, tspan,X0, h_ref);

% Plot
figure;

set(groot, 'defaultTextInterpreter', 'latex');
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
set(groot, 'defaultLegendInterpreter', 'latex');

subplot(4,1,1)
plot(t_exact,x_exact,'k-', 'LineWidth',1.5);
hold on;
plot(t_FE,X_FE,'r.-','MarkerSize', 15);
grid on;
ylabel('$x(t)\;(-)$');
title('Forward Euler');

subplot(4,1,2)
plot(t_exact,x_exact,'k-', 'LineWidth',1.5);
hold on;
plot(t_BE,X_BE,'b.-','MarkerSize', 15);
grid on;
ylabel('$x(t)\;(-)$');
title('Backward Euler');

subplot(4,1,3)
plot(t_exact,x_exact,'k-', 'LineWidth',1.5);
hold on;
plot(t_EM,X_EM,'g.-','MarkerSize', 15);
grid on;
ylabel('$x(t)\;(-)$');
title('Explicit Midpoint');

subplot(4,1,4)
plot(t_exact,x_exact,'k-', 'LineWidth',1.5);
hold on;
plot(t_IM,X_IM,'m.-','MarkerSize', 15);
grid on;
ylabel('$x(t)\;(-)$');
xlabel('Time $(-)$');
title('Implicit Midpoint');


% Shared legend at the top using a fake plot
p1 = plot(nan, nan, 'k-', 'LineWidth', 1.5);
p2 = plot(nan, nan, 'r.-');
p3 = plot(nan, nan, 'b.-');
p4 = plot(nan, nan, 'g.-');
p5 = plot(nan, nan, 'm.-');

% Shared legend in two rows
lgd = legend([p1, p2, p3, p4, p5], ...
    {'Analytical', 'Forward Euler', 'Backward Euler', ...
     'Explicit Midpoint', 'Implicit Midpoint'}, ...
    'NumColumns', 3, ...
    'Orientation', 'horizontal', ...
    'Location', 'southoutside');

lgd.Units = 'normalized';
lgd.Position = [0.12, 0.001, 0.76, 0.055];
set(gcf, 'Position', [100, 100, 800, 950]);
sgtitle('');  % Remove the default overall title

annotation('textbox', [0.1, 0.91, 0.8, 0.04], ...
    'String', 'Stability Comparison, $h_{\mathrm{ref}} = 0.45$', ...
    'Interpreter', 'latex', ...
    'FontSize', 15, ...
    'FontWeight', 'bold', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'middle');