function [ savingsYield, yieldFFund, yieldFPension, yieldPFund, yieldPPension ] ...
          = compareSavingsAlternatives( budget, quartals, N, binWidth, imageName )
    load('Funds.mat')
    
    if exist('S', 'var') == 0
        error('Price history vector S not found')
    end
    
    savingsRate = 0.03; % 3%
    [~, savingsYield] = s0679689_simulateSaving(budget, savingsRate, quartals);
    sprintf('Spaarrekening rendement: %f', savingsYield)

    yieldFFund = s0679689_simulateFundInvesting(budget, quartals, S(:,1), N);
    sprintf('Aandelenonds VTI: min %f, max %f, avg %f', [min(yieldFFund), max(yieldFFund), mean(yieldFFund)])
    yieldFPension = s0679689_simulatePensionFundInvesting(budget, quartals, S(:,1), N);
    sprintf('Pensioenfonds VTI: min %f, max %f, avg %f', [min(yieldFPension), max(yieldFPension), mean(yieldFPension)])

    yieldPFund = s0679689_simulateFundInvesting(budget, quartals, S(:,2), N);
    sprintf('Aandelenonds BNP: min %f, max %f, avg %f', [min(yieldPFund), max(yieldPFund), mean(yieldPFund)])
    yieldPPension = s0679689_simulatePensionFundInvesting(budget, quartals, S(:,2), N);
    sprintf('Pensioenfonds BNP: min %f, max %f, avg %f', [min(yieldPPension), max(yieldPPension), mean(yieldPPension)])

    fig = figure; hold all;
    %binWidth = 0.02*max(max(yieldsPensionF), max(yieldsPensionP));
    histogram(yieldFFund, 'BinWidth', binWidth, 'Normalization', 'probability');
    histogram(yieldPFund, 'BinWidth', binWidth, 'Normalization', 'probability');
    legend('VTI Aandelen', 'BNP Aandelen');
    saveas(fig, strcat(imageName, '-fund.png'));

    fig = figure; hold all;
    %binWidth = 0.02*max(max(yieldsPensionF), max(yieldsPensionP));
    histogram(yieldFPension, 'BinWidth', binWidth, 'Normalization', 'probability');
    histogram(yieldPPension, 'BinWidth', binWidth, 'Normalization', 'probability');
    legend('VTI Pensioen', 'BNP Pensioen');
    saveas(fig, strcat(imageName, '-pension.png'));
end

