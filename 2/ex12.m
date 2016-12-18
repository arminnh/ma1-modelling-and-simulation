load('MovieLens20M_Subset.mat')

[U20, s20, V20, ~] = r0679689_rank1MatrixPursuit(R, 20, T);
rmse

num2str(U20, 2)
num2str(s20, 2)
num2str(V20, 2)