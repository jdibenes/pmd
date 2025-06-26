
function [C, s] = math_fit_conic(p)
x = p(1, :);
y = p(2, :);
z = p(3, :);

eq = [x.^2; x.*y; y.^2; x.*z; y.*z; z.^2];
[C, s] = math_solve_homogeneous(eq.');
end
