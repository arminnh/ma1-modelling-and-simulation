load('MovieLens20M_Subset.mat')

profile on
[movieIDs, scores] = r0679689_actualBestMovies(R);
profile viewer

n = 25;
topNScoresAndMovies = [num2str(scores(1:n), '%.2f,'), ...
                       num2str(movieIDs(1:n), '%i, '), ...
                       char(movieLabel(movieIDs(1:n)))];
disp(topNScoresAndMovies)