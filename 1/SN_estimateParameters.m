function [ mu, sigma ] = SN_estimateParameters( s )
%SN_estimateParameters estimates parameters of log-yields of given price evolution vector

    x = SN_logYields(s);
                    
    sigma = std(x); 
    % de standaardafwijking van de log-rendementen is een 
    % schatter voor de populatiestandaardafwijking σ
    
    mu = mean(x) + 0.5 * sigma^2;   
    % Het gemiddelde van de log-rendementen is dan een schatter 
    % voor het populatiegemiddelde μ − 0.5 * σ^2

end