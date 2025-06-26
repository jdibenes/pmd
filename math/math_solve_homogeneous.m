
function [v, s] = math_solve_homogeneous(A)
[~, S, V] = svd(A);
v = V(:, end);
d = min(size(S));
s = S(d, d);
end
