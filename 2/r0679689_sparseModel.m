function [X] = r0679689_sparseModel(Uk, sk, Vk, A)
% Versie van stap 5 van het "successive rank-1 deflation" algoritme voor ijle matrices
    
    % initialize result matrix
    X = sparse(size(A, 1), size(A, 2));
    
    % get rows and cols for S. S should be a diagonal matrix, but matlab's svd provides a "full" SVD of A where S is not always diagonal
    [~, S_rows] = size(Uk);
    [~, S_cols] = size(Vk);
    
    % initialize S
    S = sparse(S_rows, S_cols);
    for i = 1:length(sk)
        S(i, i) = sk(i);
    end
    
    % find at which positions A has values, then calculate output values only for those positions
    [I, J] = find(A);
    
    X(I, J) = Uk(I, :) * S * Vk(J, :)';
    X(A == 0) = 0;
    
    %{
    % FULL MATRIX VERSION
    Xx = zeros(size(A, 1), size(A, 2));
    tmp = Uk * diag(sk) * Vk';
    Xx(I, J) = tmp(I, J);
    %whos tmp
    %whos Xx
    %}
end

