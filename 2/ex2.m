close all

m = 48769;
n = 4901;

r = linspace(1, 500, 500);

fullSize = m * n; % 239016869
coordinaatSize = 16 * r;
lagerangSize = 8 * r * (m + n); % 429360 .. 214680000

fig = figure;
hold on;
plot(r, coordinaatSize);
plot(r, lagerangSize);
legend('Coordinaatformaat', 'Lagerangbenadering');

saveas(fig, 'ex2.png')
