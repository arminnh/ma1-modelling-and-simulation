clear
load('MovieLens20M_Subset.mat')

mu = r0679689_userMeans(R);

[sorted, indices] = sort(mu);

fprintf('De drie laagste gemiddelde beoordelingen zijn: \n')
fprintf('\t %.2f van gebruiker %d\n', sorted(1), indices(1))
fprintf('\t %.2f van gebruiker %d\n', sorted(2), indices(2))
fprintf('\t %.2f van gebruiker %d\n', sorted(3), indices(3))

amount = length(mu(mu == 5));
fprintf('%d gebruikers hebben een gemiddelde score van exact 5.\n', amount)
