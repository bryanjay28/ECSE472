function [L ,U] = gaussianLU(A)
% function to compute the gaussian algorithm

shape = size(A);

L = eye(shape);
U = zeros(shape);

% iterate through the matrix until the end of the shap
for k = 1:shape(1)
    % perform the calculations on the submatrix
    for i = k+1:shape(1)
        for j = k:shape(2)
            % divide column by the pivot
            if k == j 
                A(i,j) = A(i,j)/A(j,j);
            else
                A(i,j) = A(i,j) - A(i,k)*A(k,j);
            end
        end
    end
end

U = A;

for i = 1:shape(1)
   for j = 1:shape(2)
       if i > j
           L(i,j) = A(i,j);
           U(i,j) = 0;
       end 
   end
end

end