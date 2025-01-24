
clear all

% Settings ----------------------------------------------------------------

name     = 'cvpr25_rebuttal';
N        = 10000;
lines    = 13;
px_noise = 0;

% -------------------------------------------------------------------------

load(['../data/z_' name '_' num2str(N) '_' num2str(lines) '.mat']);

K       = pose_parameters.K;
k_d     = pose_parameters.k_d;
P1      = pose_parameters.P1;
P2      = pose_parameters.P2;
scale   = pose_parameters.scale;
offset  = pose_parameters.offset;
options = pose_parameters.options;
id_v    = pose_parameters.id_v;
id_o    = pose_parameters.id_o;

P1_x = P1(1, :);
P2_x = P2(1, :);
P1_h = cam_xy_to_xy1(P1);
P2_h = cam_xy_to_xy1(P2);
l_h  = cross(P2_h, P1_h);

pxn_noise = cam_dx_to_dxn(K, px_noise);

pmodel = ...
pat_model(P1(1, 2), P1(1, 5), P1(1, 7), P1(1, 9), P1(1, 12), P1(2, 1), ...
          P2(1, 2), P2(1, 5), P2(1, 7), P2(1, 9), P2(1, 12), P2(2, 1));
row1 = 1;
row2 = 400;

error_R_ang = zeros(N, 5);
error_R_abs = zeros(N, 5);
error_t_abs = zeros(N, 5);
error_t_rel = zeros(N, 5);
error_t_ang = zeros(N, 5);
error_z_neg = false(N, 1);

for k = 1:N
disp([k, N])

%

[R, t, d, P, gt_xyn, s, xdn, ydn, user] = pose_unpack(poses(:, k));

dxn     = (noise(k, :).' * pxn_noise);
x_start = xdn(:) + dxn;
xyn     = undistortPoints([x_start, ydn*ones(numel(x_start), 1)], options.distortion).';
xy1n    = cam_xy_to_xy1(xyn);

[a1, za1, PA1] = pat_find(K, R, t, P1(:,  2), math_unit(P2(:,  2) - P1(:,  2)), row1);
[b1, zb1, PB1] = pat_find(K, R, t, P1(:,  5), math_unit(P2(:,  5) - P1(:,  5)), row1);
[c1, zc1, PC1] = pat_find(K, R, t, P1(:,  7), math_unit(P2(:,  7) - P1(:,  7)), row1);
[d1, zd1, PD1] = pat_find(K, R, t, P1(:,  9), math_unit(P2(:,  9) - P1(:,  9)), row1);
[e1, ze1, PE1] = pat_find(K, R, t, P1(:, 12), math_unit(P2(:, 12) - P1(:, 12)), row1);

[a2, za2, PA2] = pat_find(K, R, t, P1(:,  2), math_unit(P2(:,  2) - P1(:,  2)), row2);
[b2, zb2, PB2] = pat_find(K, R, t, P1(:,  5), math_unit(P2(:,  5) - P1(:,  5)), row2);
[c2, zc2, PC2] = pat_find(K, R, t, P1(:,  7), math_unit(P2(:,  7) - P1(:,  7)), row2);
[d2, zd2, PD2] = pat_find(K, R, t, P1(:,  9), math_unit(P2(:,  9) - P1(:,  9)), row2);
[e2, ze2, PE2] = pat_find(K, R, t, P1(:, 12), math_unit(P2(:, 12) - P1(:, 12)), row2);

[pat1, pat2] = pat_set1D_stereo([], [], [a1, b1, c1, d1, e1, a2, b2, c2, d2, e2]);
pat1.row = row1;
pat2.row = row2;
[pat1, pat2] = pat_extract_stereo(pmodel, K, K, pat1, pat2);

%

indices_6 = [3, 5, 6, 7, 8, 9];
[R_6_all, t_6_all] = pmd_solver_6pt(P1_h(:, indices_6), P2_h(:, indices_6), xy1n(:, indices_6));
[R_6, t_6] = pxp_select(R_6_all, t_6_all, eye(3), [0;0;0], pat2.ne, pat2.E);

indices_7 = [3, 5, 6, 7, 8, 9, 11];
[R_7, t_7] = pmd_solver_7pt(P1_h(:, indices_7), P2_h(:, indices_7), xy1n(:, indices_7));

indices_8 = [3, 5, 6, 7, 8, 9, 11, 12];
[R_8, t_8, ~, ~] = pmd_solver_8pt(P1_h(:, indices_8), P2_h(:, indices_8), xy1n(:, indices_8), l_h(:, indices_8));

[Rb_6, tb_6] = pxp_x6(eye(3),[0;0;0], pat1, pat2);

[Rb_10, tb_10] = pxp_v2(eye(3), [0;0;0], pat1, pat2);

%

error_z_neg(k) = (za1 > 0) && (zb1 > 0) && (zc1 > 0) && (zd1 > 0) && (ze1 > 0) && ...
                 (za2 > 0) && (zb2 > 0) && (zc2 > 0) && (zd2 > 0) && (ze2 > 0);

[error_R_ang(k, 1), error_R_abs(k, 1), error_t_abs(k, 1), error_t_rel(k, 1), error_t_ang(k, 1)] = pose_compute_error(R, t, R_6,   t_6);
[error_R_ang(k, 2), error_R_abs(k, 2), error_t_abs(k, 2), error_t_rel(k, 2), error_t_ang(k, 2)] = pose_compute_error(R, t, R_7,   t_7);
[error_R_ang(k, 3), error_R_abs(k, 3), error_t_abs(k, 3), error_t_rel(k, 3), error_t_ang(k, 3)] = pose_compute_error(R, t, R_8,   t_8);
[error_R_ang(k, 4), error_R_abs(k, 4), error_t_abs(k, 4), error_t_rel(k, 4), error_t_ang(k, 4)] = pose_compute_error(R, t, Rb_6,  tb_6);
[error_R_ang(k, 5), error_R_abs(k, 5), error_t_abs(k, 5), error_t_rel(k, 5), error_t_ang(k, 5)] = pose_compute_error(R, t, Rb_10, tb_10);
end

save(['results_' name '_' num2str(N) '_' num2str(lines) '.mat'], 'error_z_neg', 'error_R_ang', 'error_R_abs', 'error_t_abs', 'error_t_rel', 'error_t_ang');

function [e_r_ang, e_r_abs, e_t_abs, e_t_rel, e_t_ang] = pose_compute_error(R_gt, t_gt, R, t)
e_r_qua = quatmultiply(rotm2quat(R), quatconj(rotm2quat(R_gt)));
e_r_ang = 2*atan2(norm(e_r_qua(2:4)), e_r_qua(1));
e_r_abs = norm(R - R_gt, 'fro');
e_t_abs = norm(t - t_gt);
e_t_rel = (e_t_abs / norm(t_gt))*100;
e_t_ang = abs(atan2(norm(cross(t, t_gt)), dot(t, t_gt)));
end
