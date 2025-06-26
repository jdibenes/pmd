
function [error_R, error_t, error_n, error_a] = pose_evaluate(Rs, ts, R_gt, t_gt, mode)
N = size(Rs, 3);
error_R = zeros([N, 1]);
error_t = zeros([N, 1]);
error_n = zeros([N, 1]);
error_a = zeros([N, 1]);

for k = 1:N
    rs = rotm2axang(Rs(:, :, k));
    r_gt = rotm2axang(R_gt);
    dn = acosd(math_clamp(dot(rs(1:3), r_gt(1:3)), -1, 1));
    
    %dr = acosd(math_clamp((trace(Rs(:, :, k).'*R_gt)-1)/2, -1, 1));%rotm2axang(Rs(:, :, k).'*R_gt);
    dr = acos(math_clamp((trace(Rs(:, :, k).'*R_gt)-1)/2, -1, 1)) * 180 / pi;%rotm2axang(Rs(:, :, k).'*R_gt);
    error_R(k) = dr;
    
    da = acosd(math_clamp(dot(math_unit(ts(:, k)), math_unit(t_gt)), -1, 1));
    
    switch (mode)
    case 'norm',     dt = norm(ts(:, k) - t_gt);
    case 'relative', dt = norm(ts(:, k) - t_gt) / norm(t_gt);
    otherwise,       error('Unknown Mode');
    end

    error_t(k) = dt;
    error_n(k) = dn;
    error_a(k) = da;
end
end
