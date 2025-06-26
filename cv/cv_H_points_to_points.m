
function [H, s] = cv_H_points_to_points(srcph, dstph)
fill = zeros(size(srcph, 2), 3);

A = [(srcph .* dstph(3, :)).',                     fill, -(srcph .* dstph(1, :)).';
                         fill, (srcph .* dstph(3, :)).', -(srcph .* dstph(2, :)).'];

[h, s] = math_solve_homogeneous(A);
H = [h(1:3).'; h(4:6).'; h(7:9).'];
end
