function [s] = r0679689_optimalCoefficients(Uk, Vk, A)
% find the optimal solution for least squares problem min(|| a - Bx ||)

    [m, k] = size(Uk);
    [n, ~] = size(Vk);
    
    B = sparse([], [], [], m*n, k, nnz(A) * k);
    for i = 1:k
        tmp = r0679689_sparseModel(Uk(:, i), 1, Vk(:, i), A);
        B(:, i) = tmp(:);
    end

    s = lsqr(B, A(:));
end

%{
% FULL MATRIX VERSION
BBB = zeros(mn, k);
for i = 1:k
    tmp = Uk(:, i) * Vk(:, i)';
    BBB(1:m*n, i) = tmp(:);
end
%}

%{
% SPARSE MATRIX VERSION 1
[I, J] = find(A);
BB = sparse(zeros(mn, k));
for i = 1:k
    tmp = sparse(m, n);
    tmp(I, J) = Uk(I, i) * Vk(J, i)';
    BB(:, i) = tmp(:);
end
%}