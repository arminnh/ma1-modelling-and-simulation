function [ path, yield ] = SN_simulateSaving(budget, rate, quartals)
% Simulates the path of a savings account with given start budget and interest rate after a given amount of quartals

    investedCapital = SN_investedCapital(budget, quartals);
    path = budget;
    %deposited = budget;
    tax = 0.15;
    
    for q = 2:quartals
        path(q) = path(q-1) + budget;
        %deposited(q) = budget;
        
        if q > 4
            %path(i) = path(i) + (deposited(i-4)*rate);
            path(q) = path(q) + (path(q-4)*rate);
        end
        
        if mod(q, 4) == 0
            budget = budget * 1.02;
        end
    end

    %yield = (path(end) - sum(deposited)) / sum(deposited);
    yield = (path(end) - investedCapital) / investedCapital;
    
end

