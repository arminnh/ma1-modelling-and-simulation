clear
clc
close all
format bank
load('MovieLens20M_Subset.mat')

% 12 x 6
tmp = [ 4.0 4.5 0.0 5.0 0.0 3.5;
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
        4.0 3.0 0.0 0.0 2.0 2.0; ];
    
% 1200 x 600
%in = sparse(repmat(tmp, 100));

[U, s, V, rmse] = r0679689_rank1MatrixPursuit(tmp, 3, tmp);
num2str(rmse, 4)
approx = U*diag(s)*V';
num2str(approx', 2)

[movieIDs, score] = r0679689_actualBestMovies(tmp)
[movieIDs, score] = r0679689_actualBestMovies(approx)
[movieIDs, score] = r0679689_predictedBestMovies(U, s, V)

[movieIDs, score] = r0679689_actualBestMovies(R)
