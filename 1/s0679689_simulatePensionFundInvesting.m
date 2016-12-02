function [ yields ] = s0679689_simulatePensionFundInvesting(budget, quartals, historicalPrice, N)
% Monte Carlo simulation of periodical investments in a pension fund  
    
    % estimate parameters of evolution of fund worth
    [mu, sigma] = s0679689_estimateParameters(historicalPrice);
    yields = zeros(quartals, 1);
    
    for q = 1:N
        % simulate path for worth of fund
        pricePath = s0679689_simulateQuarterlyPath(historicalPrice(end), mu, sigma, quartals);
        
        % simulate yield of investing in the fund
        [~, yield] = s0679689_simulatePensionFundInvestingPath(budget, pricePath, quartals);
        yields(q) = yield;
    end
end