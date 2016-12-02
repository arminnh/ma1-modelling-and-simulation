% Vergelijk de empirische cdf van de log-rendementen van opeenvolgende maanden van het fonds VTI met de cdf van het model

close all
load('Funds.mat')

[f1, x1] = ecdf(r0679689_logYields(S(:, 1)));

[mu, sigma] = r0679689_estimateParameters(S(:, 1));
[f2, x2] = ecdf(normrnd(mu - 0.5 * sigma^2, sigma^2, length(S(:, 1)), 1));

fig = figure;
hold on;
plot(f1);
plot(f2);
hold off;
legend('cdf van log-rendementen', 'cdf van model');
saveas(fig, 'ex5.png');

clear