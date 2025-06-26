
function [H, s] = cv_H_points_to_lines(h_p, h_l)
l_sz = size(h_p, 3);
p_sz = size(h_p, 2);

A = zeros(l_sz * p_sz, 9);

for n = 1:l_sz
for k = 1:p_sz
    p = h_p(:, k, n).';
    A(((n - 1)*p_sz) + k, :) = [h_l(1, k) * p, h_l(2, k) * p, h_l(3, k) * p];
end
end

[h, s] = math_solve_homogeneous(A);
H = [h(1:3), h(4:6), h(7:9)].';
end
