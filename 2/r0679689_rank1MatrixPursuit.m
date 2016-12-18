function [U, s, V, rmse] = r0679689_rank1MatrixPursuit(R, k, T)
% Rank-1 matrix pursuit for completing an incomplete matrix R
%{ 
IN
    R = sparse matrix of known ratings, size(R) = m, n
    k = desired rank for approximation, 1 < k < min(m, n)
    T = sparse matrix of known ratings, size(T) = m, n
OUT 
    U, s, V form the low-rank approximation R' of R, R' = U * diag(s) * V'
    rsme contains the root-mean-square error between incomplete matrix T 
    and P(omega)(R) where omega is the sparsity pattern of T

    size(U) = m, k
    size(s) = k
    size(V) = n, k
    size(rsme) = k

Also, approximation R' = W * F' = U * diag(s) * V'
%}

    [m, n] = size(R);
    rmse = zeros(k,1);
    U = zeros(m,k);
    V = zeros(n,k);
    U(:,1) = r0679689_userMeans(R);
    V(:,1) = ones(n,1);
    fprintf('processing for j = 1\n')
    S = r0679689_sparseModel(U(:,1),1,V(:,1),R);
    P = r0679689_sparseModel(U(:,1),1,V(:,1),T);
    E = R - S;
    rmse(1) = r0679689_RMSE(T,P);
    
    for j = 2 : k 
        fprintf('processing for j = %i\n', j)
        [u,~,v] = svds(E,1);
        U(:,j) = u;
        V(:,j) = v;
        s = r0679689_optimalCoefficients(U(:,1:j),V(:,1:j),R);
        S = r0679689_sparseModel(U(:,1:j),s,V(:,1:j),R);
        P = r0679689_sparseModel(U(:,1:j),s,V(:,1:j),T);
        E = R - S;
        rmse(j) = r0679689_RMSE(T,P);
    end
end