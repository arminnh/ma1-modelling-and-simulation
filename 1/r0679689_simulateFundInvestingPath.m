function [ path, yield ] = r0679689_simulateFundInvestingPath(budget, pricePath, quartals)
% Simulate the path of the worth of investing in a distribution fund with a certain pricePath
% path = "de totale nettoinventariswaarde van alle fractionele aandelen"
% during main calculation, path = amount of shares
% after main calculation, path = total net worth of shares at each quartal
    
    investedCapital = r0679689_investedCapital(budget, quartals);
    
    transactionCosts = 10;                            % 10 euros
    stockMarketTax = 0.0027;                          % 0.27%
    dividendYield = 0.0195;                           % 1.95%
    dividendTax = (1-0.15) * (1-0.30);                % 15% bronbelasting & 30% roerende voorheffing
    dividendYieldNet = dividendYield * dividendTax;   % 1.16025%
    quarterlyDividentYieldNet = dividendYieldNet / 4; % 0.2900625%
    
    path = zeros(1, quartals);
    path(1) = (budget-transactionCosts) * (1-stockMarketTax) / pricePath(1);
    
    for q = 2:quartals
        % each quartal, receive dividents
        dividend = path(q-1) * pricePath(q) * quarterlyDividentYieldNet; 
        
        % calculate net budget to buy shares
        budgetNet = (budget + dividend - transactionCosts) * (1-stockMarketTax);
        
        % buy new shares with budget and dividend ("Dit ganse bedrag wordt dan
        % onmiddellijk opnieuw geinvesteerd in VTI-aandelen.")
        path(q) = path(q-1) + budgetNet / pricePath(q);
        
        % budget increases with 2% each year
        if mod(q, 4) == 0
            budget = budget * 1.02;
        end
    end

    path = path .* pricePath; % convert shares into the money they are worth
    yield = (path(end) - investedCapital) / investedCapital;
end

