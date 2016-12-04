% Simuleer het rendement van het BNP-pensioenfonds na 160 kwartalen 
% met volgende spaarbudgetten: 125, 250, 500, 1000 en 2000.

close all
load('Funds.mat')

budgets = [125, 250, 500, 1000, 2000];
quartals = 160;
N = 100000;

yields = zeros(1, length(budgets));

for i=1:length(budgets)
    pensionYields = r0679689_simulatePensionFundInvesting(budgets(i), quartals, S(:,2), N);
    yields(i) = mean(pensionYields);
end

fig = figure;
plot(budgets, yields);
legend('rendementen');
saveas(fig, 'ex16.png');

fprintf('Gegevens over de eindrendementen: min %f, max %f, mean %f, median %f\n', [min(yields), max(yields), mean(yields), median(yields)])