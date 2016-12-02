function [ path, yield ] = r0679689_simulateSaving(budget, rate, quartals)
% Simulates the path of a savings account with given start budget and interest rate after a given amount of quartals

    investedCapital = r0679689_investedCapital(budget, quartals);
    path = budget;
    withholdingTax = 0.15;
    
    for q = 2:quartals
        netBudget = budget;
        
        % loyalty bonus on the money that was constant on the account last year
        if q > 4
            netBudget = netBudget + (path(q-4) * rate * (1-withholdingTax)); 
        end 
        
        % add money to savings account
        path(q) = path(q-1) + netBudget;
        
        if mod(q, 4) == 0
            budget = budget * 1.02;
        end
    end
    
    yield = (path(end) - investedCapital) / investedCapital;
    
end