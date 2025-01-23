
clear all

% Settings ----------------------------------------------------------------

name = 'testset';
N = 100;
lines = 13;
px_noise = 0.00000;
k = 23;

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

[R, t, d, P, gt_xyn, s, xdn, ydn, user] = pose_unpack(poses(:, k));

dxn     = (noise(k, :).' * pxn_noise);
x_start = xdn(:) + dxn;
xyn     = undistortPoints([x_start, ydn*ones(numel(x_start), 1)], options.distortion).';
xy1n    = cam_xy_to_xy1(xyn);

%%

indices_6 = [3, 5, 6, 7, 8, 9];
[R_6, t_6] = pmd_solver_6pt(P1_h(:, indices_6), P2_h(:, indices_6), xy1n(:, indices_6));

indices_7 = [3, 5, 6, 7, 8, 9, 11];
[R_7, t_7] = pmd_solver_7pt(P1_h(:, indices_7), P2_h(:, indices_7), xy1n(:, indices_7));

indices_8 = [3, 5, 6, 7, 8, 9, 11, 12];
[R_8, t_8, H_8, s_8] = pmd_solver_8pt(P1_h(:, indices_8), P2_h(:, indices_8), xy1n(:, indices_8), l_h(:, indices_8));

%%
