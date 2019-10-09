function r = fsolve(fpoints ,out)
%  fsolve(fpoints ,out)
%  Obtain frequency domain response
% global variables G C b
% Inputs: fpoints is a vector containing the fequency points at which
%         to compute the response in Hz
%         out is the output node
% Outputs: r is a vector containing the value of
%            of the response at the points fpoint


% define global variables
global G C b

shape = length(fpoints);
r = zeros(shape,1);

for i = 1:shape
    x = inv(G + C*1i*2*pi*fpoints(i))*b;
    r(i) = x(out);
end

