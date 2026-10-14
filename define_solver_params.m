%Defines the struct of all the solver parameters
%OUTPUTS:
%solver_params: a MATLAB struct containing solver settings
%   solver_params.dxmin: terminate early if |x_{i+1}-x_{i}|<dxmin
%   solver_params.ftol: terminate early if |f(x_i)|<ftol
%   solver_params.max_iter: maximum number of iterations allowed
%   solver_params.dxmax: terminate early if |x_{i+1}-x_{i}|>dxmax
%       (meaning that jacobian is probably singular, which is bad)
%   solver_params.numerical_diff: boolean (0 or 1)
%           1-> numerically differentiate, 0-> use analytical derivative

function solver_params = define_solver_params()
    %initialize solver_params structure
    solver_params = struct();
    
    %dxmin terminate early variable
    solver_params.dxmin = 1e-14;
    
    %ftol terminate early variable
    solver_params.ftol = 1e-14;

    %max number of iterations
    solver_params.max_iter = 200;

    %dXmax terminate early variable
    solver_params.dXmax = 1e8;

    %numerical_diff: boolean (0 or 1)
    solver_params.dXmax = 1;
end