function [C] = r0679689_correlationMatrix(Uk, sk, Vk)
% returns the correlation matrix C that belongs to the matrix formed by Uk * diag(sk) * Vk'
% size(Uk) = m x k, size(sk) = k x 1, size(Vk) = n x k
% size(C)  = n x n
% memory complexity limit = O(k^2 + n^2)

    [m, ~] = size(Uk);
    [n, ~] = size(Vk);
    V = diag(sk) * Vk';       % O(k * n), kn < k^2 + n^2
    
    means = zeros(n, 1);      % O(n)
    stds = zeros(n, 1);       % O(n)
    for i = 1:n
        tmp = Uk * V(:, i);   % O(m)
        means(i) = mean(tmp);
        stds(i) = std(tmp);
    end
    
    C = zeros(n, n);          % O(n^2)
    for i = 1:m/n
        row_from = 1+(i-1)*n;
        
        R_j = Uk(row_from:min(row_from+n-1, m), :) * V - means'; % O(n * n)
        
        C = C + (R_j' * R_j);
    end    
    
    C = C ./ (stds .* stds') / (m - 1);
end

%{
for i = 1:n
    fprintf('correlation for movie %i\n', i)
    tic

    F_i = Uk(:, 1:length(sk)) * (sk .* Vk(i, :)'); % O(m)
    meanF_i = mean(F_i);
    stdF_i = std(F_i);

    for j = i+1:n
        F_j = Uk(:, 1:length(sk)) * (sk .* Vk(j, :)'); % O(m)
        meanF_j = mean(F_j);
        stdF_j = std(F_j);

        tmp = sum( (F_i - meanF_i).*(F_j - meanF_j) ) / (mm * stdF_i * stdF_j);
        C(i, j) = tmp;
        C(j, i) = tmp;
    end

    toc
end
%}

%{
for i = 1:n
    fprintf('correlation for movie %i\n', i)
    tic

    % calculate standard deviation using shifted data
    shift = Uk(1, :) * Vk(i, :)';
    sum_F_i = 0;
    sum_squares_shifted = 0;
    for row = 1:m
        x = Uk(row, :) * Vk(i, :)';
        sum_F_i = sum_F_i + x;
        sum_squares_shifted = sum_squares_shifted + (x - shift)^2;
    end
    stdF_i = sqrt( (sum_squares_shifted - ((sum_F_i-m*shift)^2/m)) / (m - 1));
    meanF_i = sum_F_i / m;

    for j = i+1:n

        shift = Uk(1, :) * Vk(j, :)';
        sum_F_j = 0;
        sum_squares_shifted = 0;
        for row = 1:m
            x = Uk(row, :) * Vk(j, :)';
            sum_F_j = sum_F_j + x;
            sum_squares_shifted = sum_squares_shifted + (x - shift) * (x - shift);
        end
        stdF_j = sqrt( (sum_squares_shifted - ((sum_F_j-m*shift)^2/m)) / (m - 1));
        meanF_j = sum_F_j / m;

        corrSum = 0;
        for k = 1:m
            x1 = Uk(k, :) .* sk' * Vk(i, :)' - meanF_i;
            x2 = Uk(k, :) .* sk' * Vk(j, :)' - meanF_j;
            corrSum = corrSum + x1 * x2;
        end

        tmp = corrSum / mm / stdF_i / stdF_j;
        C(i, j) = tmp;
        C(j, i) = tmp;
    end

    toc
end
%}
