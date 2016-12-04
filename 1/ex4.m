% Simuleer 10 willekeurige paden van het aandelenfonds VTI.

close all
load('Funds.mat')

[mu, sigma] = r0679689_estimateParameters(S(:, 1));
length = 60;                        % 60 months
initialPrice = 114.55;              % taken from http://www.morningstar.com/stocks/ARCX/VTI/quote.html, on 25/11/2016
initialPrice = initialPrice * 0.94; % convert to euro

fig = figure;
hold on;
for i = 1:10
    path = r0679689_simulatePath(initialPrice, mu, sigma, length);
    plot(path);
end
hold off;
saveas(fig, 'ex4.png');

clear
