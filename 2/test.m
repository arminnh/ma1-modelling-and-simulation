clear
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
full(in)
full(in');

tic
[U, s, V, rmse] = r0679689_rank1MatrixPursuit(in, 3, in);
rmse
approx = U*diag(s)*V';
num2str(approx', 2)
toc

