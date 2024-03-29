% Bereken de driftfactor mu en de volatiliteit sigma voor de twee fondsen die je hebt ingeladen in opgave 1 en neem deze op in je verslag.

load('Funds.mat')

[mu, sigma] = r0679689_estimateParameters(S(:, 1));
mu = round(mu, 3, 'significant');
sigma = round(sigma, 3, 'significant');

fprintf('Driftfactor en volatiliteit voor VTI: %f en %f \n', [mu, sigma])

[mu, sigma] = r0679689_estimateParameters(S(:, 2));
mu = round(mu, 3, 'significant');
sigma = round(sigma, 3, 'significant');

fprintf('Driftfactor en volatiliteit voor BNP: %f en %f \n', [mu, sigma])

clear