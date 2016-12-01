% functies testen

close all
format bank

investedCapital = SN_investedCapital(1000, 40);

[~, ~] = SN_simulateSaving(1000, 0.01, 4);
[~, ~] = SN_simulateSaving(1000, 0.01, 5);
[~, ~] = SN_simulateSaving(1000, 0.01, 12);
[path, yield] = SN_simulateSaving(1000, 0.01, 40);

load('Funds.mat')
[mu, sigma] = SN_estimateParameters(S(:,1));

fig1 = figure(1); % quarterly path
title('SN\_simulateQuarterlyPath(38.2919, 0.0062281, 0.0436201, 40)')

fig2 = figure(2); % fund investment path
title('SN\_simulateFundInvestingPath(1000, pricePath, 40)')

fig3 = figure(3); % pension fund investment path
title('SN\_simulatePensionFundInvesting(1000, pricePath, 40)')

yields1 = zeros(25, 1);
yields2 = zeros(25, 1);

for i = 1:25
    set(0, 'CurrentFigure', fig1)
    hold on;
    pricePath = SN_simulateQuarterlyPath(S(1, 1), mu, sigma, 40);
    plot(pricePath);
    
    set(0, 'CurrentFigure', fig2)
    hold on;
    [path, yield] = SN_simulateFundInvestingPath(1000, pricePath, 40);
    yields1(i) = yield;
    plot(path);
    
    set(0, 'CurrentFigure', fig3)
    hold on;
    [path, yield] = SN_simulatePensionFundInvestingPath(1000, pricePath, 40);
    yields2(i) = yield;
    plot(path);
end

set(0, 'CurrentFigure', fig1)
refline(0, S(1, 1));
set(0, 'CurrentFigure', fig2)
refline(0, investedCapital);
set(0, 'CurrentFigure', fig3)
refline(0, investedCapital);
saveas(fig1, 'SN_simulateQuarterlyPath.png');
saveas(fig2, 'SN_simulateFundInvestingPath.png');
saveas(fig2, 'SN_simulatePensionFundInvestingPath.png');

'VTI Fund Investing';
for i = 20:20:160
    %yields = SN_simulateFundInvesting(1000, i, S(:,1), 20);
    [mean(yields) min(yields) max(yields)];
end

'BNP Fund Investing';
for i = 20:20:160
    %yields = SN_simulateFundInvesting(1000, i, S(:,2), 20);
    [mean(yields) min(yields) max(yields)];
end

'VTI Pension Investing';
for i = 20:20:160
    yields = SN_simulatePensionFundInvesting(1000, i, S(:,1), 20);
    [mean(yields) min(yields) max(yields)]
end

'BNP Pension Investing';
for i = 20:20:160
    yields = SN_simulatePensionFundInvesting(1000, i, S(:,2), 20);
    [mean(yields) min(yields) max(yields)]
end