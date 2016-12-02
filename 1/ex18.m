% Simuleer het rendement van het VTI-fonds na 160 kwartalen 
% met volgende spaarbudgetten: 125, 250, 500, 1000 en 2000.

close all
load('Funds.mat')

budgets = [125, 250, 500, 1000, 2000];
quartals = 160;

yields = zeros(1, length(budgets));

for i=1:length(budgets)
    fundYields = s0679689_simulateFundInvesting(budgets(i), quartals, S(:,1), 10000);
    yields(i) = mean(fundYields);
end

figure
plot(yields)
yields

sprintf('Mediaan van de eindrendementen: %f', median(yields))