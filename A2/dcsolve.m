function [Xdc, dX] = dcsolve(Xguess,maxerr)
% Compute dc solution using newtwon iteration
% input: Xguess is the initial guess for the unknown vector. 
%        It should be the correct size of the unknown vector.
%        maxerr is the maximum allowed error. Set your code to exit the
%        newton iteration once the norm of DeltaX is less than maxerr
% Output: Xdc is the correction solution
%         dX is a vector containing the 2 norm of DeltaX used in the 
%         newton Iteration. the size of dX should be the same as the number
%         of Newton-Raphson iterations. See the help on the function 'norm'
%         in matlab.
global G C b 

delta_x = intmax;
x_test = Xguess;
dX = [];

% since in DC this point is always 0
x_test_d = [0 ; 0 ; 0 ];

% continue iterating through until the threshold of maxerr is hit
while delta_x >= maxerr
    f = f_vector(x_test);
    phi = G*x_test + C*x_test_d + f - b;

    % Get the Jacobian matrix
    J = nlJacobian(x_test);   
    
    % get delta_x matrix 
    delta_x_m = -1 * inv(J) * phi; 
    
    % caclulate the new point to test and get the normal of delta_x
    x_test = x_test + delta_x_m;    
    delta_x = norm(delta_x_m);

    dX = [ dX , delta_x ];
end

Xdc = x_test;
