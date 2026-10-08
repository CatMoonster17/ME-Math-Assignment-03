clear;
clc;
close all;

% Time interval and target step size
tspan = [0 20];
h_ref = 0.38;
X0 = 1;

% Analytical solution
t_exact = linspace(tspan(1),tspan(2),1000);
x_exact = solution01(t_exact);

% Forward Euler
%[t_FE,X_FE,h_FE,eval_FE] = ...
%    fixed_step_integration(@rate_func01, @forward_euler_step, tspan,X0, h_ref);

% Backward Euler
%[t_BE,X_BE,h_BE,eval_BE] = ...
%    fixed_step_integration(@rate_func01, @backward_euler_step, tspan,X0,h_ref);

% Explicit Midpoint
[t_EM,X_EM,h_EM,eval_EM] = ...
    fixed_step_integration(@rate_func01, @explicit_midpoint_step, tspan,X0,h_ref);

% Implicit Midpoint
[t_IM,X_IM,h_IM,eval_IM] = ...
    fixed_step_integration(@rate_func01, @implicit_midpoint_step, tspan,X0, h_ref);

% Plot
figure;

% subplot(4,1,1)
% plot(t_exact,x_exact,'k-', 'LineWidth',1.5);
% hold on;
% plot(t_FE,X_FE,'r.-');
% grid on;
% ylabel('x(t)');
% title('Forward Euler');
% legend('Analytical','Numerical');

% subplot(4,1,2)
% plot(t_exact,x_exact,'k-', 'LineWidth',1.5);
% hold on;
% plot(t_BE,X_BE,'b.-');
% grid on;
% ylabel('x(t)');
% title('Backward Euler');
% legend('Analytical','Numerical');

subplot(4,1,3)
plot(t_exact,x_exact,'k-', 'LineWidth',1.5);
hold on;
plot(t_EM,X_EM,'g.-');
grid on;
ylabel('x(t)');
title('Explicit Midpoint');
legend('Analytical','Numerical');

subplot(4,1,4)
plot(t_exact,x_exact,'k-', 'LineWidth',1.5);
hold on;
plot(t_IM,X_IM,'m.-');
grid on;
ylabel('x(t)');
xlabel('Time');
title('Implicit Midpoint');
legend('Analytical','Numerical');

sgtitle('Stability Comparison, h_{ref} = 0.38');