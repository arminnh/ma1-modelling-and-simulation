function [movieIDs, score] = r0679689_actualBestMovies(R)
% Returns a list of movies and their scores, sorted on scores in descending order
% R is a sparse matrix of known reviews of users for movies, size(R) = m, n
    
    means = r0679689_userMeans(R');
    [score, movieIDs] = sort(means, 'descend');

end

