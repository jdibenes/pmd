
function [ok, d, P, xyn, s, xdn] = pose_generate_full(k1, k2, R, t, P1, P2, ydn, options)
lines = size(P1, 2);

d   = zeros(1, lines);
P   = zeros(3, lines);
xyn = zeros(2, lines);
s   = zeros(1, lines);
xdn = zeros(1, lines);

for k = 1:lines
[ok, d(k), P(:, k), xyn(:, k), s(k), xdn(k)] = pose_generate_sample(k1, k2, R, t, P1(:, k), P2(:, k), ydn, options);
if (ok ~= 0), return; end
end

if (~all(abs(xdn(2:end) - xdn(1:(end-1))) >= options.min_dxdn)),                                                                 ok = 3; return; end
if (max(vecnorm(xyn - undistortPoints([xdn(:), ydn*ones(numel(xdn), 1)], options.distortion).')) > options.threshold_undistort), ok = 4; return; end
end
