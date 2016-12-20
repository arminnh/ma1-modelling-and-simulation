function [movieIDs, score] = r0679689_predictedBestMovies(Uk, sk, Vk)
% returns a list of movieIDs with their scores, sorted on scores in descending order
% the scores are averages based on the full matrix of user reviews R_k = Uk * diag(sk) * Vk'
% size(Uk) = m, k, size(sk) = k, size(Vk) = n, k
% memory complexity constraint = O(max(m, n))

    m = size(Uk, 1);
    n = size(Vk, 1);
    
    score = zeros(n, 1); % O(n)
    for movie = 1:n
        tmp = sk .* Vk(movie, :)'; % O(k), k < max(m, n)
        sum = 0;
        for rating = 1:m
            sum = sum + Uk(rating, :) * tmp; % O(k), k < max(m, n)
        end
        score(movie) = sum / m;
    end
    [score, movieIDs] = sort(score, 'descend');
end

%{
% FULL MATRIX VERSION       
Rk = Uk * diag(sk) * Vk'; % O(m * n) > O(max(m, n))
[movieIDs, score] = r0679689_actualBestMovies(Rk);
%}
