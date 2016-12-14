%A = [11 22 ; 44 55 ]
%A = [11 22 33 ; 44 0 66 ; 77 88 0 ; 0 7 0]
A = [11 22 33 12 58 78 45 0; 
     44  0 66  5  0  2  0 0; 
     77 88  0  0  0  0  0 0;
      0  7  0  0  0  4  5 0]

fprintf('norm(A, "fro") = %f \n', norm(A, 'fro'))
fprintf('norm(A(:), "fro") =  %f \n', norm(A(:), 'fro'))
fprintf('norm(A(:)) = %f \n', norm(A(:)))

[U S V] = svd(A);
S
fprintf('norm(A - U*S*V", "fro") = %f \n', norm(A - U*S*V', 'fro'))

s_result = r0679689_optimalCoefficients(U, V, A)
S2 = zeros(size(S, 1), size(S, 2));
for i = 1:length(s_result)
    S2(i, i) = s_result(i);
end
fprintf('norm(A - U*S_result*V", "fro") = %f \n', norm(A - U*S2*V', 'fro'))

s_result = diag(r0679689_optimalCoefficients(U(:, 1:2), V(:, 1:2), A))
fprintf('norm(A - U(:, 1:2)*s_result*V(:, 1:2)", "fro") = %f \n', norm(A - U(:, 1:2)*s_result*V(:, 1:2)', 'fro'))

s_result = diag(r0679689_optimalCoefficients(U(:, 1), V(:, 1), A))
fprintf('norm(A - U(:, 1)*s_result*V(:, 1)", "fro") = %f \n', norm(A - U(:, 1)*s_result*V(:, 1)', 'fro'))

