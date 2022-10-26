
function [ok, d, P, xyn, s, xdn] = pose_generate_sample(k1, k2, R, t, P1, P2, ydn, options)
d   = 0;
P   = zeros(3, 1);
xyn = zeros(2, 1);
s   = 0;
xdn = 0;

cplx_d = roots(pose_d_quintic(k1, k2, R, t, P1, P2, ydn));
real_d = real(cplx_d(imag(cplx_d) <= options.threshold_imaginary));

N         = numel(real_d);
valid_d   = zeros(1, N);
valid_P   = zeros(3, N);
valid_xyn = zeros(2, N);
valid_s   = zeros(1, N);
valid_xdn = zeros(1, N);
index     = 0;

for c_d = real_d.'
if ((c_d < options.min_d) || (c_d > options.max_d)),         continue; end
c_xdn = pose_d_to_xd(k1, k2, R, t, P1, P2, c_d);
if ((c_xdn < options.min_xdn) || (c_xdn > options.max_xdn)), continue; end
c_P   = math_interpolate(P1, P2, c_d);
c_xys = cam_transform(R, t, c_P);
c_s   = c_xys(3);
if (c_s < options.min_s),                                    continue; end
c_xyn = cam_xy1_to_xy(cam_xyw_to_xy1(c_xys));

index = index + 1;

valid_d(:,   index) = c_d;
valid_P(:,   index) = c_P;
valid_xyn(:, index) = c_xyn;
valid_s(:,   index) = c_s;
valid_xdn(:, index) = c_xdn;
end

if (index < 1), ok = 1; return; end
if (index > 1), ok = 2; return; end

ok  = 0;
d   = valid_d(:, 1);
P   = valid_P(:, 1);
xyn = valid_xyn(:, 1);
s   = valid_s(:, 1);
xdn = valid_xdn(:, 1);
end
