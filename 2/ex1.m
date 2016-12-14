close all
clear
load('MovieLens20M_Subset.mat')

fig = figure;
spy(R(1:1000, 1:1000));
saveas(fig, 'ex1_R.png');

fig = figure;
spy(T(1:1000, 1:1000));
saveas(fig, 'ex1_T.png');
