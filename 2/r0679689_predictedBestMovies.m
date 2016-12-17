function [movieIDs, score] = r0679689_predictedBestMovies(Uk, sk, Vk)
% returns a list of movie IDs with their scores, list is sorted on scores in descending order
% approximate a matrix of user reviews R_k = Uk * diag(sk) * Vk'
% then calculate the average scores for the movies and sort the movies using their scores

%{
    size(Uk) = m, k
    size(sk) = k
    size(Vk) = n, k

    memory complexity constraint = O(max(m, n))

    example matrix 48769 x 4901 => SVD with k = 20: 48769x20 * 20x20 * 4901x20
    48769 * 4901 * 8 / 1024^3 = 1.78 TB
%}

    [m, k] = size(Uk);
    [n, ~] = size(Vk);
    
    if (k > min(m, n))
        error('Rank k of approximation should be less than min(m, n)')
    end
    
    score = zeros(n, 1);
    for movie = 1:n
        approxRatingsForMovie = Uk * diag(sk) * Vk(:, movie)';
        % mem complexity of Uk                            = O(m * k)
        % mem complexity of Uk * diag(sk)                 = O(m * k)
        % mem complexity of Uk * diag(sk) * Vk(:, movie)' = O(m * 1)
        % => use a deeper for loop and calculate each rating per, add it
        % to an accumulator per movie and then calculate the averages => O(max(m, n))
        score(movie) = mean(approxRatingsForMovie);
    end
    [movieIDs, score] = sort(score);

    % Rk = Uk * diag(sk) * Vk'; 
    % [movieIDs, score] = r0679689_actualBestMovies(Rk);
    % memory complexity: m * n > max(m, n), this will not fit in memory  
end