function [Xb, num_evals] = forward_euler_step(rate_func_in, t, Xa, h);
    dX = rate_func_in(t, Xa);
    Xb = Xa + h*dX;
    num_evals = 1;
end
