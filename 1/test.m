% functies testen

close all
format bank

investedCapital = r0679689_investedCapital(1000, 40);
fprintf('Invested capital: %f\n', investedCapital)

[path, yield] = r0679689_simulateSaving(1000, 0.01, 40);
fprintf('Yield on savings with interest rate of 0.01: %f\n', yield)

load('Funds.mat')
[mu1, sigma1] = r0679689_estimateParameters(S(:,1));
[mu2, sigma2] = r0679689_estimateParameters(S(:,2));
quartals = 40;
budget = 1000;

fig1 = figure(1);
subplot(1, 2, 1)
title('simulateQuarterlyPath VTI')
subplot(1, 2, 2)
title('simulateFundInvestingPath VTI')

fig2 = figure(2);
subplot(1, 2, 1)
title('simulateQuarterlyPath BNP')
subplot(1, 2, 2)
title('simulatePensionFundInvestingPath BNP')

length = 500;
yields1 = zeros(length, 1);
yields2 = zeros(length, 1);

for i = 1:length
    set(0, 'CurrentFigure', fig1)
    subplot(1, 2, 1)
    hold on;
    pricePath = r0679689_simulateQuarterlyPath(S(end, 1), mu1, sigma1, quartals);
    plot(pricePath);
    
    set(0, 'CurrentFigure', fig1)
    subplot(1, 2, 2)
    hold on;
    [path, yield] = r0679689_simulateFundInvestingPath(budget, pricePath, quartals);
    yields1(i) = yield;
    plot(path);
    
    set(0, 'CurrentFigure', fig2)
    subplot(1, 2, 1)
    hold on;
    pricePath = r0679689_simulateQuarterlyPath(S(end, 2), mu2, sigma2, quartals);
    plot(pricePath);
    
    set(0, 'CurrentFigure', fig2)
    subplot(1, 2, 2)
    hold on;
    [path, yield] = r0679689_simulatePensionFundInvestingPath(budget, pricePath, quartals);
    yields2(i) = yield;
    plot(path);
end

set(0, 'CurrentFigure', fig1);
subplot(1, 2, 1);
refline(0, S(end, 1));
subplot(1, 2, 2);
refline(0, investedCapital);
set(0, 'CurrentFigure', fig2);
subplot(1, 2, 1);
refline(0, S(end, 2));
subplot(1, 2, 2);
refline(0, investedCapital);

saveas(fig1, 'r0679689_simulateFundInvestingPath.png');
saveas(fig2, 'r0679689_simulatePensionFundInvestingPath.png');

fprintf('Yield on VTI funds: min %f, max %f, mean %f, median %f\n', [min(yields1), max(yields1), mean(yields1), median(yields1)])
fprintf('Yield on BNP pension funds: min %f, max %f, mean %f, median %f\n', [min(yields2), max(yields2), mean(yields2), median(yields2)])