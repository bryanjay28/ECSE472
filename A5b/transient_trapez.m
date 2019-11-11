function [tpoints,r] = transient_trapez(t1,t2,h,out)
% [tpoints,r] = Transient_trapez(t1,t2,h,out)
% Perform Transient Analysis using the Trapezoidal Rule for LINEAR
% circuits.
% assume zero initial condition.
% Inputs:  t1 = starting time point (typically 0)
%          t2 = ending time point
%          h  = step size
%          out = output node
% Outputs  tpoints = are the time points at which the output
%                    was evaluated
%          r       = value of the response at above time points
% plot(tpoints,r) should produce a plot of the transient response

global G C b

x0 = zeros(size(G,2),1);

tpoints = t1:h:t2;

r = zeros(1,length(tpoints));

% assuming zero for IC
x_n = zeros(size(b));

for i=1:length(tpoints)-1
    x_n = inv(G + 2 * C / h) * (BTime(tpoints(i+1)) + BTime(tpoints(i)) + (2 * C / h - G) * x_n);
    
    r(i+1) = x_n(out);
end
