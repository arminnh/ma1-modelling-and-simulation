function [path] = r0679689_simulateQuarterlyPath(price, mu, sigma, quartals)
% Simulates a possbile path of the worth of a fund over a given amount of quartals

    path = zeros(1, quartals);
    path(1) = price;
    
    for q = 2:quartals
        path(q) = r0679689_brownianMove(path(q-1), mu, sigma, 3);
    end
end

