
function [R_w, t_w] = pmd_solver_6pt(P1h, P2h, ph)
Oh = pmd_origin();

h_o = pmd_origin_projection(P2h(:, 2:6), ph(:, 2:6));
h_o = cam_xyw_to_xy1(h_o);

qB = math_unit(P2h(:, 2) - P1h(:, 2));
qC = math_unit(P2h(:, 4) - P1h(:, 4));
qD = math_unit(P2h(:, 6) - P1h(:, 6));

qb = math_unit(ph(:, 2));
qc = math_unit(ph(:, 4));
qd = math_unit(ph(:, 6));

Q = [
    pmd_coefficients_6pt(h_o, qb, qB);
    pmd_coefficients_6pt(h_o, qc, qC);
    pmd_coefficients_6pt(h_o, qd, qD);
];

XYZ = math_E3Q3(Q);

XYZ_re = real(XYZ);
XYZ_im = all(imag(XYZ) < 1e-9, 2);

XYZ = XYZ_re(XYZ_im, :);

N = size(XYZ, 1);

R_w  = zeros(3, 3, N);
t_w  = zeros(3, N);

keep = true(N, 1);

cr1 = math_crossratio_2DH(ph(:, 1), ph(:, 2), ph(:, 4), ph(:, 6), h_o);
d1 = pat_cr_to_d(P1h(:, 1), P2h(:, 1), P2h(:, 2), P2h(:, 4), P2h(:, 6), Oh, cr1);
Ah = math_interpolate(P1h(:, 1), P2h(:, 1), d1);
A = [Ah(1:2); 0];

for n = 1:N
    [R, d] = math_R_cayley(XYZ(n, 1), XYZ(n, 2), XYZ(n, 3));
    R = R / d;
    
    [~, ~, V] = svd([ph(:, 1), -h_o,  -R*A]);    
    sa = V(1, end) / V(3, end);
    so = V(2, end) / V(3, end);
    t = so * h_o;
    C = -R.'*t;
    
    keep(n) = (sa >= 0) && (so >= 0) && (C(3) > 0);
	R_w(:, :, n) = R;
    t_w(:, n) = t;
end

R_w = R_w(:, :, keep);
t_w = t_w(:, keep);
end
