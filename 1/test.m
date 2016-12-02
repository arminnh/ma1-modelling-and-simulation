% functies testen

close all
format bank

investedCapital = s0679689_investedCapital(1000, 40);
sprintf('Invested capital: %f', investedCapital)

[path, yield] = s0679689_simulateSaving(1000, 0.01, 40);
sprintf('Yield on savings with 1% interest: %f', yield)

load('Funds.mat')
[mu1, sigma1] = s0679689_estimateParameters(S(:,1));
[mu2, sigma2] = s0679689_estimateParameters(S(:,2));
quartals = 40;
budget = 1000;

fig1 = figure(1); % quarterly path VTI
title('s0679689\_simulateQuarterlyPath(, 0.0062281, 0.0436201, 40)')

fig2 = figure(2); % fund investment path
title('s0679689\_simulateFundInvestingPath(1000, pricePath, 40)')

fig3 = figure(3); % quarterly path BNP
title('s0679689\_simulateQuarterlyPath(38.2919, 0.0062281, 0.0436201, 40)')

fig4 = figure(4); % pension fund investment path
title('s0679689\_simulatePensionFundInvesting(1000, pricePath, 40)')

yields1 = zeros(25, 1);
yields2 = zeros(25, 1);

for i = 1:10000
    set(0, 'CurrentFigure', fig1)
    hold on;
    pricePath = s0679689_simulateQuarterlyPath(S(end, 1), mu1, sigma1, quartals);
    plot(pricePath);
    
    set(0, 'CurrentFigure', fig2)
    hold on;
    [path, yield] = s0679689_simulateFundInvestingPath(budget, pricePath, quartals);
    yields1(i) = yield;
    plot(path);
    
    set(0, 'CurrentFigure', fig3)
    hold on;
    pricePath = s0679689_simulateQuarterlyPath(S(end, 2), mu2, sigma2, quartals);
    plot(pricePath);
    
    set(0, 'CurrentFigure', fig4)
    hold on;
    [path, yield] = s0679689_simulatePensionFundInvestingPath(budget, pricePath, quartals);
    yields2(i) = yield;
    plot(path);
end

set(0, 'CurrentFigure', fig1)
refline(0, S(end, 1));
set(0, 'CurrentFigure', fig2)
refline(0, investedCapital);
set(0, 'CurrentFigure', fig3)
refline(0, S(end, 2));
set(0, 'CurrentFigure', fig4)
refline(0, investedCapital);
saveas(fig1, 's0679689_simulateQuarterlyPath.png');
saveas(fig2, 's0679689_simulateFundInvestingPath.png');
saveas(fig2, 's0679689_simulatePensionFundInvestingPath.png');

sprintf('Yield on VTI funds: min %f, max %f, mean %f, median %f', [min(yields1), max(yields1)])
sprintf('Yield on BNP pension funds: min %f, max %f, mean %f, median %f', [])

%{
'VTI Fund Investing';
for i = 20:20:160
    %yields = s0679689_simulateFundInvesting(1000, i, S(:,1), 20);
    [mean(yields) min(yields) max(yields)];
end

'BNP Fund Investing';
for i = 20:20:160
    %yields = s0679689_simulateFundInvesting(1000, i, S(:,2), 20);
    [mean(yields) min(yields) max(yields)];
end

'VTI Pension Investing';
for i = 20:20:160
    yields = s0679689_simulatePensionFundInvesting(1000, i, S(:,1), 20);
    [mean(yields) min(yields) max(yields)]
end

'BNP Pension Investing';
for i = 20:20:160
    yields = s0679689_simulatePensionFundInvesting(1000, i, S(:,2), 20);
    [mean(yields) min(yields) max(yields)]
end
%}