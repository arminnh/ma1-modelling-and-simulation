function [path] = SN_simulatePath(initialPrice, mu, sigma, months)
%SN_SIMULATEPATH Simulate a Brownian motion

    path = initialPrice;
    for t = 2:months
        path(t) = path(t-1) * exp(mu - sigma * (0.5*sigma + normrnd(0, 1)));
    end
end