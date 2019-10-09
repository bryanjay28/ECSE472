function [L, U] = doolittleLU(A)
% function to compute the Doolittle algorithm
shape = size(A);

L = zeros(shape);
U = zeros(shape);

for i = 1:shape(1)
    % fill upper triangle
    for k = 1:shape(2)
        sum = 0;
        for m = 1:i-1
            sum = sum + (L(i,m)* U(m,k));
        end
        % Calculate the matrix element
        U(i,k) = A(i,k) - sum;
    end 
    
    % fill up the lower triangle
    for k = 1:shape(2)
       if i == k
           L(i,i) = 1; % set the diagonal as 1 
       else
           sum = 0;
           for m=1:i-1
              sum = sum + (L(k,m)*U(m,i));
           end
           
           % Calculate the matrix element
           L(k,i) = (A(k,i) - sum)/U(i,i);
       end 
    end
end 

end