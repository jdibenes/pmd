
clear all

% -------------------------------------------------------------------------

load('stereoParamsFinal.mat');

K   = stereoParams.CameraParameters1.IntrinsicMatrix.';
k_d = stereoParams.CameraParameters1.RadialDistortion;

% -------------------------------------------------------------------------

%P2_x = [-1.25, -1.00, -0.75, -0.75, -0.50, -0.25, 0.00, 0.25, 0.50, 0.75, 0.75, 1.00, 1.25];
%P1_x = [-1.25, -1.00, -0.75,  0.00,  0.00,  0.00, 0.00, 0.00, 0.00, 0.00, 0.75, 1.00, 1.25];

%P2_x = [-2, -1.5, -1, -0.5, 0, 0.5, 1, 1.5, 2];
%P1_x = [-2, -1.5,  0,  0,   0, 0,   0, 1.5, 2];

P2_x = [-2, -1.5, -1, -0.5, 0, 0.5, 1, 1.5, 2];
P1_x = [-2, -1.5, -1, -0.5, 0, 0.5, 1, 1.5, 2];

%id_v = [1:3, 7, 11:13];
%id_o = 4:10;
id_v = [1:2, 5, 8:9];
id_o = 3:7;

cr1 = pat_crossratio(P2_x(id_o(1)), P2_x(id_o(2)), P2_x(id_o(3)), P2_x(id_o(4)));
cr2 = pat_crossratio(P2_x(id_o(2)), P2_x(id_o(3)), P2_x(id_o(4)), P2_x(id_o(5)));

P2_y = 2.5;
P1_y = 0;

N      = 100;
name   = 'testset';
scale  = 20;
offset = [0; 1; 0];
ydn    = cam_y_to_yn(K, 1);

options.min_d               = 0.1;
options.max_d               = 0.9;
options.min_xdn             = cam_x_to_xn(K, 1);
options.max_xdn             = cam_x_to_xn(K, 3840);
options.min_s               = 1;
options.min_dxdn            = cam_dx_to_dxn(K, 16);
options.threshold_imaginary = 1e-9;
options.threshold_undistort = 1e-9;
options.distortion          = cameraParameters('RadialDistortion', k_d);

% ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

noise_s = 0.5;

k1 = k_d(1);
k2 = k_d(2);

lines = size(P1_x, 2);

P1 = [P1_x; P1_y*ones(1, lines); zeros(1, lines)];
P2 = [P2_x; P2_y*ones(1, lines); zeros(1, lines)];

P2_h = P2;
P2_h(3, :) = 1;
P1_h = P1;
P1_h(3, :) = 1;
l_h = cross(P2_h, P1_h);

[sz_fixed, sz_line] = pose_packet_size();
poses = zeros(pose_packet_rows(sz_fixed, sz_line, lines, 1), N);

delta_x = zeros(1, N);
delta_y = zeros(1, N);

for k = 1:N
disp(k);
[R, t, d, P, xyn, s, xdn] = pose_generate_row(k1, k2, scale, offset, P1, P2, ydn, options);
poses(:, k) = pose_pack(R, t, d, P, xyn, s, xdn, ydn, 0);

xdn_n = xdn + noise_s/K(1,1)*randn(1, numel(xdn));

p = undistortPoints([xdn_n(:), ydn*ones([numel(xdn), 1])], options.distortion).';
p = [p; ones(1, size(p, 2))];

pb = p(:, id_o(1));
pm6 = p(:, id_o(2));
pc = p(:, id_o(3));
pm7 = p(:, id_o(4));
pd = p(:, id_o(5));

h_o_gt = R(:, 2) / R(3, 2);%cross(l_h(:, id_o(1)), l_h(:, id_o(2)));%t / t(3);

[l1, l2, l3] = pmd_conic_lines(pb, pm6, pc, pm7, pd, cr1, cr2);
%[h_o, H, ~] = pmd_homography_p2xyw(p, l_h);
%h_o = h_o / h_o(3);
h_o = cross(l1, l3);
h_o = h_o / h_o(3);
%h_o = h_o / h_o(3);

delta_x(k) = h_o_gt(1) - h_o(1);
delta_y(k) = h_o_gt(2) - h_o(2);
end

noise = randn(N, lines);

pose_parameters           = [];
pose_parameters.K         = K;
pose_parameters.k_d       = k_d;
pose_parameters.P1        = P1;
pose_parameters.P2        = P2;
pose_parameters.scale     = scale;
pose_parameters.offset    = offset;
pose_parameters.options   = options;
pose_parameters.id_v      = id_v;
pose_parameters.id_o      = id_o;

%save(['./data/z_' name '_' num2str(N) '_' num2str(lines) '.mat'], 'poses', 'pose_parameters', 'noise');
