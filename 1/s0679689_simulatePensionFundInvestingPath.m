function [ path, yield ] = s0679689_simulatePensionFundInvestingPath(budget, pricePath, quartals)
% Simulate the path of a pension fund
    investedCapital = s0679689_investedCapital(budget, quartals);
    
    runningCosts = 0.0125; % 1.25%
    initialFee = 0.03;     % 3% "Om fractionele eenheden van het BNP-fonds aan te kopen"
    maxTaxReturn = 282;    % 282 euro
        
    path = budget * (1-initialFee);
     
    for q = 2:quartals
        % calculate net budget to buy shares
        budgetNet = budget * (1-initialFee);
        
        % yearly tax return of 30% of previous year's investment, max 282 euro. 
        % every 1st of april. use this money to invest in more shares
        % assume first investment is in january
        if q > 5 && mod(q, 4) == 2
            taxReturn = 0.3 * sum(path(q-5:q-2));
            if taxReturn > maxTaxReturn
                taxReturn = maxTaxReturn;
            end
            budgetNet = budgetNet + taxReturn;
        end
        
        % buy new shares
        path(q) = path(q-1) + budgetNet / pricePath(q);
        
        % budget increases with 2% each year
        if mod(q, 4) == 0
            budget = budget * 1.02;
            maxTaxReturn = maxTaxReturn * 1.02;
        end
    end

    path = path .* pricePath; % convert shares into the money they are worth
    yield = (path(end) - investedCapital) / investedCapital;
end