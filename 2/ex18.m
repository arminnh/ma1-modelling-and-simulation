clear
clc
load('MovieLens20M_Subset.mat')

profile on
[U20, s20, V20] = r0679689_rank1MatrixPursuit(R, 20, T);
C = r0679689_correlationMatrix(U20, s20, V20);
%[U20, s20, V20] = svds(R, 20);
%C = r0679689_correlationMatrix(U20, diag(s20), V20);
profile viewer

n = [    10     5     3     3     9];
k = [   446  3854  4355  2747   160];

for i = 1:length(n)
    IDs = r0679689_similarMovies(C, k(i), n(i));
    
    fprintf('%i most similar movies for %s (id %i):\n', n(i), char(movieLabel(k(i))), k(i))
    disp([repmat(['    '], n(i), 1), char(movieLabel(IDs))])
    disp(' ')
end
