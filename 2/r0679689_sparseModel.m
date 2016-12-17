function [X] = r0679689_sparseModel(Uk, sk, Vk, A)
% Versie van stap 5 van het "successive rank-1 deflation" algoritme voor ijle matrices

    % initialize result matrix
    X = sparse(size(A, 1), size(A, 2));
    
    % get rows and cols for S
    [~, S_rows] = size(Uk);
    [~, S_cols] = size(Vk);
    
    % initialize S
    S = sparse(S_rows, S_cols);
    for z = 1:length(sk)
        S(z, z) = sk(z);
    end
    
    % find at which positions A has values, then calculate output values only for those positions
    [I, J] = find(A);
    
    for z = 1:length(I)
        %fprintf('i = %i, j = %i', I(z), J(z))
        %Uk(I(z), :)
        %sk(I(z))
        %S
        %Vk(J(z), :)'
        %X(I(z), J(z)) = Uk(I(z), :) * sk(I(z)) * Vk(J(z), :)'
        X(I(z), J(z)) = Uk(I(z), :) * S * Vk(J(z), :)';
    end
    
end
    
%{
% FIRST SPARSE MATRIX VERSION, "X2(I, J) =" takes too much memory at once
X2 = sparse(size(A, 1), size(A, 2));
X2(I, J) = Uk(I, :) * S * Vk(J, :)';
X2(A == 0) = 0;
whos X
whos X2
%}

%{
% FULL MATRIX VERSION
Xx = zeros(size(A, 1), size(A, 2));
tmp = Uk * diag(sk) * Vk';
Xx(I, J) = tmp(I, J);
%whos tmp
%whos Xx
%}
