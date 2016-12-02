% Simuleer het rendement van het VTI-fonds na 160 kwartalen 
% met volgende spaarbudgetten: 125, 250, 500, 1000 en 2000.

close all
load('Funds.mat')

budgets = [125, 250, 500, 1000, 1500, 2000, 2500, 3000, 3500, 4000];
budgets = [125, 250, 500, 1000, 2000];
quartals = 160;
N = 100000;

yields = zeros(1, length(budgets));

for i=1:length(budgets)
    fundYields = r0679689_simulateFundInvesting(budgets(i), quartals, S(:,1), N);
    yields(i) = mean(fundYields);
end

figure
plot(yields)

fprintf('Mediaan van de eindrendementen: %f\n', median(yields))