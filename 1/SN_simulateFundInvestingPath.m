function [ path, yield ] = SN_simulateFundInvestingPath( budget, pricePath, quartals)
% Simulate the path of a distribution fund
% path = "de totale nettoinventariswaarde van alle fractionele aandelen"
% during main calculation, path = amount of shares
% after main calculation, path = total net worth of shares at each quartal
    
    investedCapital = SN_investedCapital(budget, quartals);
    
    transactionCosts = 10;     % 10 euros
    stockMarketTax = 0.0027;   % 0.27%
    dividendYield = 0.0195;    % 1.95%
    dividendTax = (1-0.15) * (1-0.30); % 15% bronbelasting & 30% roerende voorheffing
    dividendYieldNet = dividendYield * dividendTax;   % 1.16%
    quarterlyDividentYieldNet = dividendYieldNet / 4; % 0.29%
    
    path = (budget-transactionCosts) * (1-stockMarketTax) / pricePath(1);
     
    for q = 2:quartals
        % each quartal, receive dividents on last quartal
        dividend = pricePath(q-1) * quarterlyDividentYieldNet; 
        
        % calculate net budget to buy shares
        budgetNet = (budget-transactionCosts) * (1-stockMarketTax);
        
        % buy new shares with net budget and dividend ("Dit ganse bedrag wordt dan
        % onmiddellijk opnieuw geinvesteerd in VTI-aandelen.")
        path(q) = path(q-1) + (dividend + budgetNet) / pricePath(q);
        
        % budget increases with 2% each year
        if mod(q, 4) == 0
            budget = budget * 1.02;
        end
    end

    path = path .* pricePath; % convert shares into the money they are worth
    yield = (path(end) - investedCapital) / investedCapital;

end

