

function [tpoints,r] = nl_transient_beuler(t1,t2,h,out)
% [tpoints,r] = beuler(t1,t2,h,out)
% Perform transient analysis for NONLINEAR Circuits using Backward Euler
% Assume zero initial condition.
% Inputs:  t1 = starting time point (typically 0)
%          t2 = ending time point
%          h  = step size
%          out = output node
% Outputs  tpoints = are the time points at which the output
%                    was evaluated
%          r       = value of the response at above time points
% plot(tpoints,r) should produce a plot of the transient response

global G C b

tpoints = t1:h:t2;

r = zeros(1,length(tpoints));
maxerr = 10^(-6);

% assuming zero for IC
x_n = zeros(size(b));
x_n1 = zeros(size(b));

for i=1:length(tpoints)-1   
    delta_x = intmax();
    
    while delta_x >= maxerr
        f = f_vector(x_n1);
        phi = f + (G + C / h) * x_n1 - BTime(tpoints(i+1)) - (C / h) * x_n;

        % Get the Jacobian matrix
        J = nlJacobian(x_n1);   
        phi_d = G + C/h + J;

        % get delta_x matrix 
        delta_x_m = -1 * inv(phi_d) * phi; 

        % caclulate the new point to test and get the normal of delta_x
        x_n1 = x_n1 + delta_x_m;    
        delta_x = norm(delta_x_m);
    end
    r(i+1) = x_n1(out);
    x_n = x_n1;
end
   