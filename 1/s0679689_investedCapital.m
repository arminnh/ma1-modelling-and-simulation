function [ capital ] = SN_investedCapital(budget, quartals)
% calculates budget after given amount of quartals
    capital = 0;
    
    while quartals > 0
        if quartals >= 4
            capital = capital + 4 * budget;
            quartals = quartals - 4;
        else
            capital = capital + quartals * budget;
            quartals = 0;
        end
        
        budget = budget * 1.02;
    end
end

