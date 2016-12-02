% Simuleer het rendement van het BNP-pensioenfonds na 160 kwartalen 
% met volgende spaarbudgetten: 125, 250, 500, 1000 en 2000.

close all
load('Funds.mat')

budgets = [125, 250, 500, 1000, 2000];
quartals = 160;

yields = zeros(1, length(budgets));

for i=1:length(budgets)
    pensionYields = s0679689_simulatePensionFundInvesting(budgets(i), quartals, S(:,2), 1000);
    yields(i) = mean(pensionYields);
end

figure
plot(yields)
yields

sprintf('Mediaan van de eindrendementen: %f', median(yields))