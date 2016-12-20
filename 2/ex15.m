clear
clc
load('MovieLens20M_Subset.mat')

n = 25;

fprintf('Processing actualBestMovies...\n')
[movieIDs, scores] = r0679689_actualBestMovies(R);

disp('average rating - movie ID - movie name - number of reviews')
topNScoresAndMovies = [num2str(scores(1:n), '%.2f'),    repmat(' - ', n, 1), ...
                       num2str(movieIDs(1:n), '%i'),    repmat(' - ', n, 1), ...
                       char(movieLabel(movieIDs(1:n))), repmat(' - ', n, 1), ...
                       num2str(sum(R(:, movieIDs(1:25))~=0)')];
disp(topNScoresAndMovies)

fprintf('Processing rank1MatrixPursuit...\n')
[U20, s20, V20, ~] = r0679689_rank1MatrixPursuit(R, 20, T);
fprintf('Processing predictedBestMovies...\n')
[movieIDs, scores] = r0679689_predictedBestMovies(U20, s20, V20);

topNScoresAndMovies = [num2str(scores(1:n), '%.2f'),    repmat(' - ', n, 1), ...
                       num2str(movieIDs(1:n), '%i'),    repmat(' - ', n, 1), ...
                       char(movieLabel(movieIDs(1:n))), repmat(' - ', n, 1), ...
                       num2str(sum(R(:, movieIDs(1:25))~=0)')];
disp(topNScoresAndMovies)
