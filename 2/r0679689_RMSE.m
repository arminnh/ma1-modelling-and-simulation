function [err] = r0679689_RMSE(A, B)
% calculates the root mean square error between two matrices A and B
% A and B have the same sparsity pattern

    %{ 
    % 2 seconds per call with the large matrices
    if any((A == 0) ~= (B == 0))
        full(A)
        full(B)
        error('Input matrices A and B should have the same sparsity patterns')
    end
    %}
    
    C = length(find(A));
    err = (1 / sqrt(C)) * norm(A - B, 'fro');
end
