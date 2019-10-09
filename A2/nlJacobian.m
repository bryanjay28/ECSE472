function J = nlJacobian(X)
% Compute the jacobian of the nonlinear vector of the MNA equations as a 
% function of X
% input: X is the current value of the unknown vector.
% output: J is the jacobian of the nonlinear vector f(X) in the MNA
% equations. The size of J should be the same as the size of G.
global G DIODE_LIST

N = size(G);
f_d = zeros(N); % Initialize the f_d (derrivative) vector (same size as G)

NbDiodes = size(DIODE_LIST,2);

% perform similar actions to the f_vector function
for I = 1:NbDiodes
    % fill the 3x3 matrix 
    if (DIODE_LIST(I).node1 ~= 0) && (DIODE_LIST(I).node2 ~= 0) 
        v1 = X(DIODE_LIST(I).node1); %nodal voltage at anode
        v2 = X(DIODE_LIST(I).node2); %nodal voltage at cathode
        Vt = DIODE_LIST(I).Vt; % Vt of diode (part of diode model)
        Is = DIODE_LIST(I).Is; % Is of Diode (part of diode model)
        
        % calculate the matrix based on having a diode with two nodes
        f_d(DIODE_LIST(I).node2, DIODE_LIST(I).node2) = f_d(DIODE_LIST(I).node2, DIODE_LIST(I).node2) + (Is/Vt)*exp((v1-v2)/Vt);
        f_d(DIODE_LIST(I).node1, DIODE_LIST(I).node1) = f_d(DIODE_LIST(I).node1, DIODE_LIST(I).node1) + (Is/Vt)*exp((v1-v2)/Vt);
        f_d(DIODE_LIST(I).node1, DIODE_LIST(I).node2) = f_d(DIODE_LIST(I).node1, DIODE_LIST(I).node2) + (-1*Is/Vt)*exp((v1-v2)/Vt);
        f_d(DIODE_LIST(I).node2, DIODE_LIST(I).node1) = f_d(DIODE_LIST(I).node2, DIODE_LIST(I).node1) + (-1*Is/Vt)*exp((v1-v2)/Vt);

%         f_d = f_d + [ (Is/Vt)*exp((v1-v2)/Vt) (-1*Is/Vt)*exp((v1-v2)/Vt) 0 ; (-1*Is/Vt)*exp((v1-v2)/Vt) (Is/Vt)*exp((v1-v2)/Vt) 0 ; 0 0 0 ];
    elseif (DIODE_LIST(I).node1 == 0)
        v2 = X(DIODE_LIST(I).node2); %nodal voltage at cathode
        Vt = DIODE_LIST(I).Vt; % Vt of diode (part of diode model)
        Is = DIODE_LIST(I).Is; % Is of Diode (part of diode model)

        % one node is connected to ground
        f_d(DIODE_LIST(I).node2, DIODE_LIST(I).node2) = f_d(DIODE_LIST(I).node2, DIODE_LIST(I).node2) + (Is/Vt)*exp(-1*v2/Vt);
%         f_d = f_d + [ 0 0 0 ; 0 (Is/Vt)*exp(-1*v2/Vt) 0 ; 0 0 0 ];
    elseif (DIODE_LIST(I).node2 == 0)
        v1 = X(DIODE_LIST(I).node1); %nodal voltage at anode
        Vt = DIODE_LIST(I).Vt; % Vt of diode (part of diode model)
        Is = DIODE_LIST(I).Is; % Is of Diode (part of diode model)
        
        % one node is connected to ground
        f_d(DIODE_LIST(I).node1, DIODE_LIST(I).node1) = f_d(DIODE_LIST(I).node1, DIODE_LIST(I).node1) + (Is/Vt)*exp(v1/Vt);
%         f_d = f_d + [ (Is/Vt)*exp(v1/Vt) 0 0 ; 0 0 0 ; 0 0 0 ];
    end
end

% return the Jacobian
J = G + f_d;


