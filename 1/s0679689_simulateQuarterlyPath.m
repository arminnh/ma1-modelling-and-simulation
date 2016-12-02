function [ path ] = s0679689_simulateQuarterlyPath(price, mu, sigma, quartals)
% Simulate the path of the worth of a fund for a given amount of quartals
    path = price;
    
    for i = 2:quartals
        path(i) = brownianMove(path(i-1), mu, sigma, 3);
    end
end

