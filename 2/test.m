clear
clc
close all
format bank
load('MovieLens20M_Subset.mat')

in = sparse(12, 6);
in(:, :) = [4.0 4.5 0.0 5.0 0.0 3.5;
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
full(in);
full(in');

%{
tic
[U, s, V, rmse] = r0679689_rank1MatrixPursuit(in, 30, in);
toc
num2str(rmse, 4) % TODO: rmse(3) should be 0.2940
approx = U*diag(s)*V';
num2str(approx', 2)
%}

profile on
[U, s, V, rmse] = r0679689_rank1MatrixPursuit(R, 2, T);
rmse
profile viewer

%{
[movieIDs, score] = r0679689_actualBestMovies(in)
[movieIDs, score] = r0679689_actualBestMovies(approx)
[movieIDs, score] = r0679689_predictedBestMovies(U, s, V)

tic
[movieIDs, score] = r0679689_actualBestMovies(R)
toc
%}