% Simuleer het rendement voor elk van de 3 scenario’s na 40, 80, 120 en 160 kwartalen 
% wanneer je spaarbudget steeds (250 + x) euro per kwartaal bedraagt, waarbij x de laatste 3 cijfers van je studentennummer zijn.

close all;
x = 689;

for q = 40:40:160
    compareSavingsAlternatives(250+x, q, 1000, 0.05, strcat('ex15-', q, '-quartals-'));
end