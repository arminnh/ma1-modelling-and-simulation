function [err] = r0679689_RMSE(A, B)
% calculates the root mean square error between two matrices A and B
    'in'
    full(A)
    full(B)
    diff = A - B;
    full(diff)
    diff(A == 0) = 0;
    full(diff')
    C = length(find(A))
    err = (1 / sqrt(C)) * norm(diff, 'fro')
    'out'
end
