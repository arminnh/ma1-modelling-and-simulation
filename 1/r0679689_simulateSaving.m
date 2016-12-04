function [path, yield] = r0679689_simulateSaving(budget, rate, quartals)
% Simulates the path of a savings account with given start budget and interest rate after a given amount of quartals

    investedCapital = r0679689_investedCapital(budget, quartals);
    
    path = zeros(1, quartals);
    path(1) = budget;
    deposits = zeros(1, 4);
    deposits(1) = budget;
    
    withholdingTax = 0.15;
    
    for q = 2:quartals
        % find which quartal of the year it is
        quartal = mod(q, 4);
        if quartal == 0 
            quartal = 4;
        end
        
        netBudget = budget;
        
        % loyalty bonus
        if q > 4
            bonus = deposits(quartal) * rate * (1-withholdingTax);
            
            netBudget = netBudget + bonus; 
            deposits(quartal) = deposits(quartal) + bonus;
        end 
        
        % add money to savings account
        path(q) = path(q-1) + netBudget;
        deposits(quartal) = deposits(quartal) + budget;
        
        if mod(q, 4) == 0
            budget = budget * 1.02;
        end
    end
    
    yield = (path(end) - investedCapital) / investedCapital;
    
end