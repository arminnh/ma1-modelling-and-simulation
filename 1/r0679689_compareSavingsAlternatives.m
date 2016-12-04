function [savingsYield, yieldF, yieldP] ...
          = r0679689_compareSavingsAlternatives(budget, quartals, N, binWidth, imageName)
    load('Funds.mat')
    
    if exist('S', 'var') == 0
        error('Price history vector S not found')
    end
    
    savingsRate = 0.03; % 3%
    [~, savingsYield] = r0679689_simulateSaving(budget, savingsRate, quartals);
    fprintf('Spaarrekening rendement: %f\n', savingsYield);

    yieldF = r0679689_simulateFundInvesting(budget, quartals, S(:,1), N);
    fprintf('Aandelenfonds VTI rendementen: min %f, max %f, mean %f, median %f\n', [min(yieldF), max(yieldF), mean(yieldF), median(yieldF)])

    yieldP = r0679689_simulatePensionFundInvesting(budget, quartals, S(:,2), N);
    fprintf('Pensioenfonds BNP rendementen: min %f, max %f, mean %f, median %f\n', [min(yieldP), max(yieldP), mean(yieldP), median(yieldP)])

    fig = figure; hold all;
    %binWidth = 0.02*max(max(yieldsPensionF), max(yieldsPensionP));
    histogram(yieldF, 'BinWidth', binWidth, 'Normalization', 'probability');
    histogram(yieldP, 'BinWidth', binWidth, 'Normalization', 'probability');
    legend('VTI', 'BNP');
    
    saveas(fig, strcat(imageName, '.png'));
end

