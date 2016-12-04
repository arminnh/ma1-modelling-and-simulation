function [mu, sigma] = r0679689_estimateParameters(s)
% estimates parameters of log-yields of given price evolution vector
    
    x = r0679689_logYields(s);
                    
    sigma = std(x); 
    % "de standaardafwijking van de log-rendementen is een 
    % schatter voor de populatiestandaardafwijking sigma"
    
    mu = mean(x) + 0.5 * sigma^2;   
    % "Het gemiddelde van de log-rendementen is dan een schatter 
    % voor het populatiegemiddelde mu - 0.5 * sigma^2"

end