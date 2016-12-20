function [err] = r0679689_RMSE(A, B)
% calculates the root mean square error between two matrices A and B
% A and B have the same sparsity pattern
    
    C = length(find(A));
    err = (1 / sqrt(C)) * norm(A - B, 'fro');
end
