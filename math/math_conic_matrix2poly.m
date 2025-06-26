
function poly = math_conic_matrix2poly(M)
A = M(1, 1);
B = M(1, 2) + M(2, 1);
C = M(2, 2);
D = M(1, 3) + M(3, 1);
E = M(2, 3) + M(3, 2);
F = M(3, 3);

poly = [A, B, C, D, E, F];
end
