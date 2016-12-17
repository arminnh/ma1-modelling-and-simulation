function [s] = r0679689_optimalCoefficients(Uk, Vk, A)
% find the optimal solution for least squares problem min(|| a - Bx ||)

    [m, k] = size(Uk);
    [n, ~] = size(Vk);
    
    % SPARSE MATRIX VERSION 2
    B = sparse(m*n, k);
    for i = 1:k
        tmp = r0679689_sparseModel(Uk(:, i), 1, Vk(:, i), A);
        B(:, i) = tmp(:);
    end
    %whos B
    
    s = lsqr(B, A(:));
    
    %{
    % SPARSE MATRIX VERSION 1
    [I, J] = find(A);
    BB = sparse(zeros(mn, k));
    for i = 1:k
        tmp = sparse(m, n);
        tmp(I, J) = Uk(I, i) * Vk(J, i)';
        BB(:, i) = tmp(:);
    end
    whos BB
    %}
    
    %{
    % FULL MATRIX VERSION
    BBB = zeros(mn, k);
    for i = 1:k
        tmp = Uk(:, i) * Vk(:, i)';
        BBB(1:m*n, i) = tmp(:);
    end
    whos BBB
    %}
end
