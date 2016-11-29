function [ path, yield ] = SN_simulateSaving(budget, rate, quartals)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    path = budget;
    deposited = budget;
    tax = 0.15;
    
    for i = 2:quartals
        path(i) = path(i-1) + budget;
        deposited(i) = budget;
        
        if i > 4
            path(i) = path(i) + (deposited(i-4)*rate);
        end
        
        if mod(i, 4) == 0
            budget = budget * 1.02;
        end
    end

    yield = (path(end) - sum(deposited)) / sum(deposited);
    
end

