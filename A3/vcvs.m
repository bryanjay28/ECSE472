function vcvs(nd1,nd2,ni1,ni2,val)
% vcvs(nd1,nd2,ni1,ni2,val)
% Add stamp for a voltage controlled voltage source
% to the global circuit representation
% val is the gain of the vcvs
% ni1 and ni2 are the controlling voltage nodes
% nd1 and nd2 are the controlled voltage nodes
% The relation of the nodal voltages at nd1, nd2, ni1, ni2 is:
% Vnd1 - Vnd2 = val*(Vni1 - Vni2)

global G
global b
global C

d = length(G);       %current size of the MNA
sz = d+1;            %new row

% increase the size of the matrix
G(sz,sz) = 0;
C(sz,sz) = 0;
b(sz) = 0;


if nd1~=0
    G(sz,nd1) = G(sz,nd1) + 1;
    G(nd1,sz) = G(nd1,sz) + 1;
end

if nd2~=0
    G(sz,nd2) = G(sz,nd2) - 1;
    G(nd2,sz) = G(nd2,sz) - 1;
end

if ni1~=0
    G(sz,ni1) = G(sz,ni1) - val;
end

if ni2~=0
    G(sz,ni2) = G(sz,ni2) + val;
end