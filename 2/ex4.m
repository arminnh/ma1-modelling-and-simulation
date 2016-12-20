int = 4;    % 4 bytes
double = 8; % 8 bytes

m = 240000;
n = 33000;
amountOfValues = 22000000; % 22 000 000 niet-nul waarden in de matrix

% volle matrx: m * n =  7 920 000 000 cellen
% ijle matrix: 2 * 22 000 000 voor i en j vectoren + 22 000 000 voor r_{i,j} waarden  = 66 000 000

memory = 8;      % 8 GB
swapMemory = 32; % 32 GB
totalMemory = (memory+swapMemory) * 1024^3; % convert to byte

% stap 4: beste rang-1 benadering zoeken: m+n getallen voor berekening + m*n opslag 
step4 = (m+n)*double + m*n*double;

% stap 5: (nieuwe matrix) = (oude matrix) - (rang-1 benadering)
step5 = m*n*double;

% stap 6:
step6 = 1 * int;

totalMemoryUsage = step4 + step5 + step6;
fprintf('Totaal bruikbaar geheugen: %iGB \n', totalMemory / 1024^3)
fprintf('Nodig geheugen met volle matrices: %.2fGB \n', totalMemoryUsage / 1024^3)

step4 = (m+n)*double + 2*amountOfValues*int + amountOfValues*double;
step5 = 2*amountOfValues*int + amountOfValues*double;
step6 = 1 * int;
totalMemoryUsage = step4 + step5 + step6;
fprintf('Nodig geheugen als het ijlhijdspatroon behouden kan worden: %.2fGB \n\n', totalMemoryUsage / 1024^3)
