function [ savingsYield, yieldFFund, yieldFPension, yieldsFundP, yieldsPensionP ] ...
          = compareSavingsAlternatives( budget, quartals, N, binWidth, imageName )
    load('Funds.mat')
    
    if exist('S', 'var') == 0
        error('Price history vector S not found')
    end
    
    savingsRate = 0.03; % 3%
    [~, savingsYield] = SN_simulateSaving(budget, savingsRate, quartals);
    sprintf('Spaarrekening rendement: %f', savingsYield)

    yieldFFund = SN_simulateFundInvesting(budget, quartals, S(:,1), N);
    sprintf('Aandelenonds VTI: min %f, max %f, avg %f', [min(yieldFFund), max(yieldFFund), mean(yieldFFund)])
    yieldFPension = SN_simulatePensionFundInvesting(budget, quartals, S(:,1), N);
    sprintf('Pensioenfonds VTI: min %f, max %f, avg %f', [min(yieldFPension), max(yieldFPension), mean(yieldFPension)])

    yieldsFundP = SN_simulateFundInvesting(budget, quartals, S(:,2), N);
    sprintf('Aandelenonds BNP: min %f, max %f, avg %f', [min(yieldsFundP), max(yieldsFundP), mean(yieldsFundP)])
    yieldsPensionP = SN_simulatePensionFundInvesting(budget, quartals, S(:,2), N);
    sprintf('Pensioenfonds BNP: min %f, max %f, avg %f', [min(yieldsPensionP), max(yieldsPensionP), mean(yieldsPensionP)])

    fig = figure; hold all;
    %binWidth = 0.02*max(max(yieldsPensionF), max(yieldsPensionP));
    histogram(yieldFFund, 'BinWidth', binWidth, 'Normalization', 'probability');
    histogram(yieldsFundP, 'BinWidth', binWidth, 'Normalization', 'probability');
    legend('VTI Aandelen', 'BNP Aandelen');
    saveas(fig, strcat(imageName, '-fund.png'));

    fig = figure; hold all;
    %binWidth = 0.02*max(max(yieldsPensionF), max(yieldsPensionP));
    histogram(yieldFPension, 'BinWidth', binWidth, 'Normalization', 'probability');
    histogram(yieldsPensionP, 'BinWidth', binWidth, 'Normalization', 'probability');
    legend('VTI Pensioen', 'BNP Pensioen');
    saveas(fig, strcat(imageName, '-pension.png'));
end

