load('MovieLens20M_Subset.mat')
profile on
%[U20, s20, V20] = r0679689_rank1MatrixPursuit(R, 20, T);
C = r0679689_correlationMatrix(U20, s20, V20);
profile viewer
n = [    10     5     4     4     9];
k = [   446  3854  4355  2747   160];

for i = 1:length(n)
    IDs = r0679689_similarMovies(C, k(i), n(i));
    
    fprintf('%i most similar movies for %s (%i):\n', n(i), movieLabel(k(i)), k(i))
    char(movieLabel(IDs))
end
