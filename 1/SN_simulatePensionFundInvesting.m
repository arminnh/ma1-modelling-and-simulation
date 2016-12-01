function [ yields ] = SN_simulatePensionFundInvesting(budget, quartals, historicalPrice, N)
% Monte Carlo simulation of periodical investments in a pension fund  

    % estimate parameters of evolution of fund worth
    [mu, sigma] = SN_estimateParameters(historicalPrice);
    yields = zeros(N, 1);
    
    for q = 1:N
        % simulate path for worth of fund
        pricePath = SN_simulateQuarterlyPath(historicalPrice(end), mu, sigma, quartals);
        
        % simulate yield of investing in the fund
        [~, yield] = SN_simulatePensionFundInvestingPath(budget, pricePath, quartals);
        
        yields(q) = yield;
    end
end