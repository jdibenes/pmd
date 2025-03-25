
clear all

name  = 'cvpr25_rebuttal';
N     = 10000;
lines = 13;
bins = 10.^(-17:0.125:-1);


load(['results_' name '_' num2str(N) '_' num2str(lines) '.mat'])

solver_6_R = error_R_ang(error_z_neg, 1);
solver_6_t = error_t_rel(error_z_neg, 1);

solver_7_R = error_R_ang(error_z_neg, 2);
solver_7_t = error_t_rel(error_z_neg, 2);

solver_8_R = error_R_ang(error_z_neg, 3);
solver_8_t = error_t_rel(error_z_neg, 3);

solver_b_6_R = error_R_ang(error_z_neg, 4);
solver_b_6_t = error_t_rel(error_z_neg, 4);

solver_b_10_R = error_R_ang(error_z_neg, 5);
solver_b_10_t = error_t_rel(error_z_neg, 5);

solver_6_R = solver_6_R(1:5000);
solver_6_t = solver_6_t(1:5000);

solver_7_R = solver_7_R(1:5000);
solver_7_t = solver_7_t(1:5000);

solver_8_R = solver_8_R(1:5000);
solver_8_t = solver_8_t(1:5000);

solver_b_6_R = solver_b_6_R(1:5000);
solver_b_6_t = solver_b_6_t(1:5000);

solver_b_10_R = solver_b_10_R(1:5000);
solver_b_10_t = solver_b_10_t(1:5000);

total = 5000;

counts_6_R = histcounts(solver_6_R, bins) / total;
counts_6_t = histcounts(solver_6_t, bins) / total;

counts_7_R = histcounts(solver_7_R, bins) / total;
counts_7_t = histcounts(solver_7_t, bins) / total;

counts_8_R = histcounts(solver_8_R, bins) / total;
counts_8_t = histcounts(solver_8_t, bins) / total;

counts_b_6_R = histcounts(solver_b_6_R, bins) / total;
counts_b_6_t = histcounts(solver_b_6_t, bins) / total;

counts_b_10_R = histcounts(solver_b_10_R, bins) / total;
counts_b_10_t = histcounts(solver_b_10_t, bins) / total;

xdata = bins(1:(end-1));


figure()
plot(xdata, counts_6_R);
hold on
plot(xdata, counts_7_R);
plot(xdata, counts_8_R);
plot(xdata, counts_b_6_R);
plot(xdata, counts_b_10_R);
set(gca, "XScale", "log");
legend({'6-pt (ours)', '7-pt (ours)', '8-pt (ours)', '6-pt [5]', '10-pt [5]'});
xlabel('Orientation error (degrees)')
ylabel('Relative frequency')
ylim([0, 0.12]);

figure()
plot(xdata, counts_6_t);
hold on
plot(xdata, counts_7_t);
plot(xdata, counts_8_t);
plot(xdata, counts_b_6_t);
plot(xdata, counts_b_10_t);
set(gca, "XScale", "log");
legend({'6-pt (ours)', '7-pt (ours)', '8-pt (ours)', '6-pt [5]', '10-pt [5]'});
xlabel('Translation error (%)')
ylabel('Relative frequency')
ylim([0, 0.12]);
