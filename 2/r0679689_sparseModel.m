function [X] = r0679689_sparseModel(Uk, sk, Vk, A)
% Versie van stap 5 van het "successive rank-1 deflation" algoritme voor ijle matrices
    
    % find at which positions A has values, then calculate output values only for those positions
    [i, j, v] = find(A);
    for val = 1:length(i)
        v(val) = Uk(i(val), :) .* sk' * Vk(j(val), :)';
    end
    X = sparse(i, j, v);
end

%{
% FULL MATRIX VERSION
Xx = zeros(size(A, 1), size(A, 2));
tmp = Uk * diag(sk) * Vk';
Xx(I, J) = tmp(I, J);
%}
    
%{
% FIRST SPARSE MATRIX VERSION, "X2(I, J) =" takes too much memory at once
X2 = sparse(size(A, 1), size(A, 2));
X2(I, J) = Uk(I, :) * S * Vk(J, :)';
X2(A == 0) = 0;
%} 
    
%{
% SECOND SPARSE MATRIX VERSION

[~, S_rows] = size(Uk);
[~, S_cols] = size(Vk);
S = sparse(S_rows, S_cols);
for z = 1:length(sk)
    S(z, z) = sk(z);
end

[I, J] = find(A);
X = sparse([], [], [], size(A, 1), size(A, 2), length(I));

for z = 1:length(I)
    X(I(z), J(z)) = Uk(I(z), :) * S * Vk(J(z), :)';
end
%}
    
%{
% SECOND SPARSE MATRIX VERSION 
    
S = sparse(1:length(sk), 1:length(sk), sk, size(Uk, 2), size(Vk, 2)); 

[I, J] = find(A);
tmp = zeros(length(I), 1); 
for z = 1:length(I)
    tmp(z) = Uk(I(z), :) * S * Vk(J(z), :)';
end
X = sparse(I, J, tmp);
%}