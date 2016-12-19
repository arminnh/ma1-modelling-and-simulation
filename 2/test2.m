%clear
%clc
format long
load('MovieLens20M_Subset.mat')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% sparse matrix of reviews, size = 12 x 6
% each column represents a stochastic variable F_i
test = [    4.0 4.5 0.0 5.0 0.0 3.5;
            4.0 0.0 3.0 0.0 5.0 3.0;
            4.5 3.5 4.0 0.0 0.0 4.0;
            0.0 4.0 3.5 0.0 3.5 3.0;
            3.0 0.0 2.5 0.0 4.0 3.5;
            0.0 3.5 3.0 4.0 0.0 3.5;
            0.0 5.0 4.0 0.0 3.5 4.0;
            4.0 4.5 0.0 4.0 4.0 0.0;
            0.0 5.0 5.0 4.5 0.0 3.5
            4.0 0.0 4.5 5.0 0.0 1.5;
            0.0 4.5 0.0 5.0 3.5 4.0;
            4.0 3.0 0.0 0.0 2.0 2.0;    ];
    
% full matrix of predicted reviews, size = 12 x 6
[U, s, V, rmse] = r0679689_rank1MatrixPursuit(test, 3, test);
test = U*diag(s)*V';
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[m, n] = size(test);

% s = diagonal matrix of standard deviatons of samples of stochastic variables F_i
S = diag(std(test));

% v = vector of means of samples of stochastic variables F_i, size = n
v = mean(test)';

% one = vector of ones, size = m
one = ones(m, 1);

%part = (tmp - one * v') * diag(1 ./ diag(S));
part = (test - one * v') * S^-1;
% C = correlation matrix of given matrix of reviews, size(C) = n x n = 6 x 6
C = (1 / (m - 1)) * (part' * part);
disp(C)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

C = r0679689_correlationMatrix(U, s, V);
num2str(C, '%.2f  ')

for i = 1:6
    IDs = r0679689_similarMovies(C, i, 3);
    
    fprintf('%i most similar movies for %i:\n', 3, i)
    disp(IDs)
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%{
[U, S, V] = svds(R);
C = r0679689_correlationMatrix(U, diag(S), V);
disp(C)

for i = 1:length(n)
    IDs = r0679689_similarMovies(C, k(i), n(i));
    
    fprintf('%i most similar movies for %s (%i):\n', n(i), movieLabel(k(i)), k(i))
    char(movieLabel(IDs))
end
%}
