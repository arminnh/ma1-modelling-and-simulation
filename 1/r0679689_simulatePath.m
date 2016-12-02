function [path] = r0679689_simulatePath(initialPrice, mu, sigma, months)
% Simulate a Brownian motion
    path = zeros(1, months);
    path(1) = initialPrice;
    
    for m = 2:months
        path(m) = r0679689_brownianMove(path(m-1), mu, sigma, 1);
    end
end