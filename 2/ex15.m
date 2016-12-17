load('MovieLens20M_Subset.mat')

n = 25;

[movieIDs, scores] = r0679689_actualBestMovies(R)
topNScoresAndMovies = [num2str(scores(1:n), '%.2f,'), ...
                       num2str(movieIDs(1:n), '%i, '), ...
                       char(movieLabel(movieIDs(1:n)))];
disp(topNScoresAndMovies)


[U20, s20, V20, ~] = r0679689_rank1MatrixPursuit(R, 20, T);
[movieIDs, scores] = r0679689_predictedBestMovies(U20, s20, V20);
topNScoresAndMovies = [num2str(scores(1:n), '%.2f,'), ...
                       num2str(movieIDs(1:n), '%i, '), ...
                       char(movieLabel(movieIDs(1:n)))];
disp(topNScoresAndMovies)