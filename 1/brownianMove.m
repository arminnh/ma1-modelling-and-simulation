function [ next_price ] = brownianMove( current_price, mu, sigma, t )
% Simulate the brownian movement for t months

    if nargin < 4
        t = 1;
    end
                             
    next_price = current_price * exp((mu - 0.5*sigma^2)*t + sigma*sqrt(t)*normrnd(0,1));
end

