function ind(n1,n2,val)
          % ind(n1,n2,val)
          % Add stamp for inductor to the global circuit representation
          % Inductor connected between n1 and n2
          % The indjuctance is val in Henry
          % global G
          % global C
          % global b
          % Date:

     % defind global variables
     global G
     global b
     global C
     
     len = length(G);
     sz = len + 1;
     
     b(sz) = 0;   
     G(sz,sz) = 0;
     
     C(sz,sz) = -val;
     
     if n2 ~= 0
        G(n2,sz) = -1;
        G(sz,n2) = -1;  
     end
        
     if n1 ~= 0
        G(n1,sz) = 1;
        G(sz,n1) = 1;
     end     

     