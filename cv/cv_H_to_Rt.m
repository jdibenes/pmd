
% Source
% https://hal.inria.fr/inria-00174036/PDF/RR-6303.pdf
function [Ra, Rb, ta, tb, na, nb] = cv_H_to_Rt(H, threshold)
I = eye(3);
S = (H.' * H) - I;

[v, path] = max(abs(diag(S)));

if (v < threshold)
    Ra = H;
    Rb = H;
    ta = [0;0;0];
    tb = [0;0;0];
    na = H(3, :);
    nb = H(3, :);
    return;
end

M_s11 = -det(math_minor(S, 1, 1));
M_s22 = -det(math_minor(S, 2, 2));
M_s33 = -det(math_minor(S, 3, 3));

switch (path)
case 1
    e_23 = math_sign1(-det(math_minor(S, 2, 3)));
    nap  = [S(1,1); S(1,2) + sqrt(M_s33); S(1,3) + e_23*sqrt(M_s22)];
    nbp  = [S(1,1); S(1,2) - sqrt(M_s33); S(1,3) - e_23*sqrt(M_s22)];
case 2
    e_13 = math_sign1(-det(math_minor(S, 1, 3)));
    nap  = [S(1,2) + sqrt(M_s33); S(2,2); S(2,3) - e_13*sqrt(M_s11)];
    nbp  = [S(1,2) - sqrt(M_s33); S(2,2); S(2,3) + e_13*sqrt(M_s11)];
case 3
    e_12 = math_sign1(-det(math_minor(S, 1, 2)));
    nap  = [S(1,3) + e_12*sqrt(M_s22); S(2,3) + sqrt(M_s11); S(3,3)];
    nbp  = [S(1,3) - e_12*sqrt(M_s22); S(2,3) - sqrt(M_s11); S(3,3)];
end

tr_S = trace(S);
v    = 2 * sqrt(1 + tr_S - M_s11 - M_s22 - M_s33);
dts  = 2 + tr_S;
te   = sqrt(dts - v);
esr  = math_sign1(S(path, path)) * sqrt(dts + v);    

na = math_unit(nap);
nb = math_unit(nbp);

tas = (te / 2) * (esr*nb - te*na);
tbs = (te / 2) * (esr*na - te*nb);

Ra = H*(I - (2 / v)*tas*na.');
Rb = H*(I - (2 / v)*tbs*nb.');

ta = Ra*tas;
tb = Rb*tbs;
end
