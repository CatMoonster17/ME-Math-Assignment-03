%Runs numerical integration using explicit midpoint approximation
%INPUTS:
%rate_func_in: the function used to compute dXdt. rate_func_in will
% have the form: dXdt = rate_func_in(t,X) (t is before X)
%tspan: a two element vector [t_start,t_end] that denotes the integration endpoints
%X0: the vector describing the initial conditions, X(t_start)
%h_ref: the desired value of the average step size (not the actual value)
%OUTPUTS:
%t_list: the vector of times, [t_start;t_1;t_2;...;.t_end] that X is approximated at
%X_list: the vector of X, [X0';X1';X2';...;(X_end)'] at each time step
%h_avg: the average step size
%num_evals: total number of calls made to rate_func_in during the integration
function [t_list,X_list,h_avg, num_evals] = ...
explicit_midpoint_fixed_step_integration(rate_func_in,tspan,X0,h_ref)
    t_start = tspan(1);
    t_end = tspan(2);
    % Find smallest N (number of steps rounded up to nearest whole number) so that h <= h_ref
    N = ceil((t_end - t_start)/h_ref);
    % step size 
    h_avg = (t_end - t_start)/N;
    t_list = linspace(t_start, t_end, N+1)';
    % X size and list
    X0 = X0(:);
    num_states = length(X0);
    X_list = zeros(N+1,num_states);
    X_list(1,:) = X0';

    num_evals = 0;

    % step through the integration
    for n = 1:N
        % current time
        t = t_list(n);
        % current states
        XA = X_list(n,:)';
        % One midpoint step
        [XB, step_evals] = explicit_midpoint_step(rate_func_in,t,XA,h_avg);
        % store results 
        X_list(n+1,:) = XB';
        % Update evaluation count
        num_evals = num_evals + step_evals;
    end
end