function [C] = r0679689_correlationMatrix(Uk, sk, Vk)
% returns the correlation matrix C that belongs to the matrix formed by Uk * diag(sk) * Vk
%{
    size(Uk) = m x k
    size(sk) = k x 1
    size(Vk) = n x k

    size(C)  = n x n
    memory complexity limit = O(k^2 + n^2)
%}

    [m, ~] = size(Uk);
    [n, ~] = size(Vk);
    C = ones(n, n); % O(n^2)
    mm = m - 1;
    
    Uk = Uk * diag(sk);
    
    for i = 1:n
        fprintf('correlation i for movie %i\n', i)
        tic
        
        F_i = Uk * Vk(i, :)'; % O(m)
        %{
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
        %}
        stdF_i = std(F_i);
        meanF_i = mean(F_i);
        F_i = F_i - meanF_i;
        
        for j = i+1:n
            F_j = Uk * Vk(j, :)'; % O(m)
            %{
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
            %}
            
            stdF_j = std(F_j);
            meanF_j = mean(F_j);
            F_j = F_j - meanF_j;
            
            %{
            corrSum = 0;
            for k = 1:m
                corrSum = corrSum + F_i(k) * F_j(k);
            end
            %}
            
            tmp = sum(F_i .* F_j) / mm / stdF_i / stdF_j;
            C(i, j) = tmp;
            C(j, i) = tmp;
        end
        %}
        
        toc
    end
end


%{
ratings
    1    3
    2    3
    5    3
means
    2.67 3

sum = (1-2.67)(3-3) + (2-2.67)(3-3) + (5-2.67)(3-3)
sum((F_i - mean(F_i) .* (F_j - mean(F_j))
%}

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

    meanF_i = 0;
    stdF_i = 0;
    for row = 1:m
        x = Uk(row, :) .* sk' * Vk(i, :)';
        meanF_i = meanF_i + x;
        stdF_i = stdF_i + x^2;
    end
    meanF_i = meanF_i / m;
    stdF_i = sqrt( (stdF_i / m) - (meanF_i)^2);

    for j = i+1:n

        meanF_j = 0;
        stdF_j = 0;
        for row = 1:m
            x = Uk(row, :) .* sk' * Vk(j, :)';
            meanF_j = meanF_j + x;
            stdF_j = stdF_j + x^2;
        end
        meanF_j = meanF_j / m;
        stdF_j = sqrt( (stdF_j / m) - (meanF_j)^2);

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
