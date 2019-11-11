function [tpoints,r] = transient_beuler(t1,t2,h,out)
% [tpoints,r] = beuler(t1,t2,h,out)
% Perform transient analysis for LINEAR Circuits using Backward Euler
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

% tpoints is a vector containing all the timepoints from t1 to t2 with step
% size h
tpoints = t1:h:t2;

r = zeros(1,length(tpoints));

% assuming zero for IC
x_n = zeros(size(b));

for i=1:length(tpoints)-1
    x_n = inv(G + C / h) * (BTime(tpoints(i+1)) + (C / h) * x_n);
    
    r(i+1) = x_n(out);
end
