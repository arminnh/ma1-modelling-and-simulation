function [mu] = r0679689_userMeans(A)
% mu is a vector of means of the rows of A

    m = size(A, 1);
    mu = zeros(m, 1);
    
    for i = 1:m
        mu(i) = mean(nonzeros(A(i, :)));
    end
end

