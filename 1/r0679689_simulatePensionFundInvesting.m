function [yields] = r0679689_simulatePensionFundInvesting(budget, quartals, historicalPrice, N)
% Monte Carlo simulation of periodical investments in a pension fund  
    
    % estimate parameters for the evolution of the fund's worth
    [mu, sigma] = r0679689_estimateParameters(historicalPrice);
    yields = zeros(1, N);
    
    for q = 1:N
        % simulate a price path for the worth of the fund
        pricePath = r0679689_simulateQuarterlyPath(historicalPrice(end), mu, sigma, quartals);
        
        % simulate the yield of investing in the fund with the simulated path
        [~, yield] = r0679689_simulatePensionFundInvestingPath(budget, pricePath, quartals);
        yields(q) = yield;
    end
end