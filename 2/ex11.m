load('MovieLens20M_Subset.mat')

profile on
[U, s, V, rmse] = r0679689_rank1MatrixPursuit(R, 30, T);
profile viewer
rmse

fig = figure;
plot(rmse)
legend('RMSE');
saveas(fig, 'ex11.png');
