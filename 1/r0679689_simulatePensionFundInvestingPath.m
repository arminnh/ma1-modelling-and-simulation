function [path, yield] = r0679689_simulatePensionFundInvestingPath(budget, pricePath, quartals)
% Simulate the path of the worth of investing in a pension fund with a certain pricePath
% during main calculation, path = amount of shares
% after main calculation, path = total net worth of shares at each quartal

    investedCapital = r0679689_investedCapital(budget, quartals);
    
    runningCosts = 0.0125; % 1.25%, unclear what to do with this
    initialFee = 0.03;     % 3% "Om fractionele eenheden van het BNP-fonds aan te kopen"
    taxReturnRate = 0.30;  % 30% of last year's investment
    maxTaxReturn = 282;    % 282 euro
        
    path = zeros(1, quartals);
    investments = zeros(1, quartals);
    path(1) = budget * (1-initialFee) / pricePath(1);
     
    for q = 2:quartals
        % calculate net budget to buy shares
        budgetNet = budget * (1-initialFee);
        
        % yearly tax return, assume first investment was in january
        if q > 5 && mod(q, 4) == 2
            taxReturn = min(maxTaxReturn, taxReturnRate * sum(investments(q-5:q-2)));
            budgetNet = budgetNet + taxReturn * (1-initialFee);
        end
        
        % buy new shares
        path(q) = path(q-1) + budgetNet / pricePath(q);
        investments(q) = budgetNet;
        
        % budget and max return increase with 2% each year
        if mod(q, 4) == 0
            budget = budget * 1.02;
            maxTaxReturn = maxTaxReturn * 1.02;
        end
    end

    path = path .* pricePath; % convert shares into the money they are worth
    yield = (path(end) - investedCapital) / investedCapital;
end