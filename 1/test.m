% functies testen

% overschrijven van beleggersrekening naar ( beurgenoteerd fonds | investering | pensioenspaarfonds )

% op de eerste dag van elk kwartaal geld storten op de beleggersrekening
%   1e kwartaal: 01/01 - 31/03
... 2e kwartaal: 01/04 - 30/06
... 3e kwartaal: 01/07 - 30/09
... 4e kwartaal: 01/10 - 31/12
% binnen een jaar elk kwartaal hetzelfde bedrag
% elk jaar verhoging van 2%

%SN_investedCapital(1000, 1)
%SN_investedCapital(1000, 2)
%SN_investedCapital(1000, 3)
%SN_investedCapital(1000, 4)
%SN_investedCapital(1000, 5)

[path deposited yield] = SN_simulateSaving(1000, 0.01, 5)