
function [R_s, t_s] = pxp_select(R, t, R2, t2, p2, P2)
N = size(t, 2);
error = zeros(1, N);

for k = 1:N   
    [R2_g, t2_g] = pose_transform2(R(:, :, k), t(:, k), R2, t2);
    [R2_w, t2_w] = pose_transform1(R2_g, t2_g);
    
    q2 = pose_transform(R2_w, t2_w, P2);
    
    error(k) = norm(q2 / q2(3) - p2);
end

[~, I] = min(error);

R_s = R(:, :, I);
t_s = t(:, I);
end
