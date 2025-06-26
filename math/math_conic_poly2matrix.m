
function M = math_conic_poly2matrix(poly)
A = poly(1);
B = poly(2) / 2;
C = poly(3);
D = poly(4) / 2;
E = poly(5) / 2;
F = poly(6);

M = [A, B, D; B, C, E; D, E, F];
end
