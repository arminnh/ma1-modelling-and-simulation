format bank
load('MovieLens20M_Subset.mat')

[U20, s20, V20, ~] = r0679689_rank1MatrixPursuit(R, 20, T);
rmse
disp(U20)
disp(s20)
disp(V20)