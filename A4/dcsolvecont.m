function Xdc = dcsolvecont(n_steps,maxerr)
% Compute dc solution using newtwon iteration and continuation method
% (power ramping approach)
% inputs:
% n_steps is the number of continuation steps between zero and one that are
% to be taken. For the purposes of this assigments the steps should be 
% linearly spaced (the matlab function "linspace" may be useful).
% maxerr is the stopping criterion for newton iteration (stop iteration
% when norm(deltaX)<maxerr

global G C b

% Vo is @ node 3
% vi is @ node 4

cont_step = linspace(0,1,n_steps);

% Set x_guess to be 0 since it's the trivial solution
x_guess = zeros(length(G), 1);  

Xdc = 0;

for i = 1:n_steps
%     Xdc = Xdc + dcsolvealpha(x_guess, cont_step(i), maxerr);
    x_guess = dcsolvealpha(x_guess, cont_step(i), maxerr);

end

Xdc = x_guess;
