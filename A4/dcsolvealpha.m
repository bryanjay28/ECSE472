function Xdc = dcsolvealpha(Xguess, alpha, maxerr)
% Compute dc solution using newtwon iteration for the augmented system
% G*X + f(X) = alpha*b
% Inputs: 
% Xguess is the initial guess for Newton Iteration
% alpha is a paramter (see definition in augmented system above)
% maxerr defined the stopping criterion from newton iteration: Stop the
% iteration when norm(deltaX)<maxerr
% Oupputs:
% Xdc is a vector containing the solution of the augmented system

global G C b

delta_x = 2147483647;
x_test = Xguess;

% since in DC this point is always 0
x_test_d = zeros(size(x_test));

% continue iterating through until the threshold of maxerr is hit
while norm(delta_x) >= maxerr
    f = f_vector(x_test);
    phi = G*x_test + C*x_test_d + f - alpha*b;

    % Get the Jacobian matrix
    J = nlJacobian(x_test);   
    
    % get delta_x matrix 
    delta_x = -1 * J \ phi; 
    
    % caclulate the new point to test and get the normal of delta_x
    x_test = x_test + delta_x;    
end

Xdc = x_test;

