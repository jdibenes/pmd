
clear all

qx = sym('qx', 'real');
qy = sym('qy', 'real');
qz = sym('qz', 'real');

[R, d] = math_R_cayley(qx, qy, qz);

o  = sym('o_',  [3, 1], 'real');
qn = sym('qn_', [3, 1], 'real');
qN = sym('qN_', [3, 1], 'real');

eq = qn.'*math_v3_to_ssm(o)*R*qN;

[Q, monomials] = poly_equations_to_matrix(eq, [qx, qy, qz], 'lexicographic');

matlabFunction(Q, 'Vars', [o; qn; qN], 'File', 'pmd_coefficients_6pt.m');
