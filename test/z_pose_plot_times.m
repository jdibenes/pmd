
clear all

name  = 'cvpr25_rebuttal';
N     = 10000;
lines = 13;
bins = 10.^(-17:0.125:-1);

load(['results_' name '_' num2str(N) '_' num2str(lines) '_time.mat'])

solver_6_s    = timec_s_abs(error_z_neg, 1);
solver_7_s    = timec_s_abs(error_z_neg, 2);
solver_8_s    = timec_s_abs(error_z_neg, 3);
solver_b_6_s  = timec_s_abs(error_z_neg, 4);
solver_b_10_s = timec_s_abs(error_z_neg, 5);

solver_6_s    = median(solver_6_s(1:5000));
solver_7_s    = median(solver_7_s(1:5000));
solver_8_s    = median(solver_8_s(1:5000));
solver_b_6_s  = median(solver_b_6_s(1:5000));
solver_b_10_s = median(solver_b_10_s(1:5000));
