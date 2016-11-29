% Simuleer 10 willekeurige paden van het aandelenfonds VTI.

close all
load('Funds.mat')

[mu, sigma] = SN_estimateParameters(S(:, 1));
length = 60; % 60 months
initialPrice = 114.55; % taken from http://www.morningstar.com/stocks/ARCX/VTI/quote.html

fig = figure
hold on
for i = 1:10
    path = SN_simulatePath(initialPrice, mu, sigma, length);
    plot(path)
end
hold off
saveas(fig,  'ex5.png')

clear