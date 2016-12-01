function [path] = SN_simulatePath(initialPrice, mu, sigma, months)
% Simulate a Brownian motion

    path = initialPrice;
    for t = 2:months
        path(t) = brownianMove(path(t-1), mu, sigma, 1);
    end
end