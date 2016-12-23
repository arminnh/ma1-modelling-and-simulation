close all

m = 48769;
n = 4901;
nonzeros = 3596544;

r = linspace(1, 500, 500);

coordinaatSize = repmat(16 * nonzeros, 500); % 57544704
lagerangSize = 8 * r * (m + n); % 429360 .. 214680000

fig = figure;
hold on;
plot(r, coordinaatSize);
plot(r, lagerangSize);
legend('Coordinaatformaat', 'Lagerangbenadering');

saveas(fig, 'ex2.png')

fprintf('Snijpunt wanneer r = %f', 2*nonzeros/(m+n))
