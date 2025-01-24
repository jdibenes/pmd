
function pmodel = pat_model(x11, x21, x31, x41, x51, min_y, x12, x22, x32, x42, x52, max_y)
pmodel.p12 = [x12; max_y; 1];
pmodel.p22 = [x22; max_y; 1];
pmodel.p32 = [x32; max_y; 1];
pmodel.p42 = [x42; max_y; 1];
pmodel.p52 = [x52; max_y; 1];

pmodel.p11 = [x11; min_y; 1];
pmodel.p21 = [x21; min_y; 1];
pmodel.p31 = [x31; min_y; 1];
pmodel.p41 = [x41; min_y; 1];
pmodel.p51 = [x51; min_y; 1];

pmodel.t1 = sym('t1', 'real');
pmodel.t5 = sym('t5', 'real');
pmodel.R1 = sym('R1', 'real');
pmodel.R5 = sym('R5', 'real');

[pmodel.n1, pmodel.s1] = math_unit(pmodel.p12 - pmodel.p11);
[pmodel.n2, pmodel.s2] = math_unit(pmodel.p22 - pmodel.p21);
[pmodel.n3, pmodel.s3] = math_unit(pmodel.p32 - pmodel.p31);
[pmodel.n4, pmodel.s4] = math_unit(pmodel.p42 - pmodel.p41);
[pmodel.n5, pmodel.s5] = math_unit(pmodel.p52 - pmodel.p51);

pmodel.lx = simplify(cross(pmodel.p11 + (pmodel.n1 * pmodel.t1), pmodel.p51 + (pmodel.n5 * pmodel.t5)));

pmodel.l1 = cross(pmodel.p11, pmodel.p12);
pmodel.l2 = cross(pmodel.p21, pmodel.p22);
pmodel.l3 = cross(pmodel.p31, pmodel.p32);
pmodel.l4 = cross(pmodel.p41, pmodel.p42);
pmodel.l5 = cross(pmodel.p51, pmodel.p52);

pmodel.lxl1 = simplify(cross(pmodel.lx, pmodel.l1));
pmodel.lxl2 = simplify(cross(pmodel.lx, pmodel.l2));
pmodel.lxl3 = simplify(cross(pmodel.lx, pmodel.l3));
pmodel.lxl4 = simplify(cross(pmodel.lx, pmodel.l4));
pmodel.lxl5 = simplify(cross(pmodel.lx, pmodel.l5));

pmodel.lxl1 = simplifyFraction(pmodel.lxl1(1:2) / pmodel.lxl1(3));
pmodel.lxl2 = simplifyFraction(pmodel.lxl2(1:2) / pmodel.lxl2(3));
pmodel.lxl3 = simplifyFraction(pmodel.lxl3(1:2) / pmodel.lxl3(3));
pmodel.lxl4 = simplifyFraction(pmodel.lxl4(1:2) / pmodel.lxl4(3));
pmodel.lxl5 = simplifyFraction(pmodel.lxl5(1:2) / pmodel.lxl5(3));

pmodel.eqn = [pat_build(pmodel.lxl1, pmodel.lxl2, pmodel.lxl3, pmodel.lxl4, pmodel.R1), pat_build(pmodel.lxl5, pmodel.lxl4, pmodel.lxl3, pmodel.lxl2, pmodel.R5)];
pmodel.var = [pmodel.t1, pmodel.t5];
pmodel.sol = solve(pmodel.eqn, pmodel.var);
pmodel.sub = [pmodel.sol.t1, pmodel.sol.t5];

pmodel.c1 = simplify(subs(pmodel.lxl1, pmodel.var, pmodel.sub));
pmodel.c2 = simplify(subs(pmodel.lxl2, pmodel.var, pmodel.sub));
pmodel.c3 = simplify(subs(pmodel.lxl3, pmodel.var, pmodel.sub));
pmodel.c4 = simplify(subs(pmodel.lxl4, pmodel.var, pmodel.sub));
pmodel.c5 = simplify(subs(pmodel.lxl5, pmodel.var, pmodel.sub));

pmodel.f1 = matlabFunction([pmodel.c1; 0], 'Vars', [pmodel.R1, pmodel.R5]);
pmodel.f2 = matlabFunction([pmodel.c2; 0], 'Vars', [pmodel.R1, pmodel.R5]);
pmodel.f3 = matlabFunction([pmodel.c3; 0], 'Vars', [pmodel.R1, pmodel.R5]);
pmodel.f4 = matlabFunction([pmodel.c4; 0], 'Vars', [pmodel.R1, pmodel.R5]);
pmodel.f5 = matlabFunction([pmodel.c5; 0], 'Vars', [pmodel.R1, pmodel.R5]);

pmodel.p12_3D = [pmodel.p12(1:2); 0];
pmodel.p22_3D = [pmodel.p22(1:2); 0];
pmodel.p32_3D = [pmodel.p32(1:2); 0];
pmodel.p42_3D = [pmodel.p42(1:2); 0];
pmodel.p52_3D = [pmodel.p52(1:2); 0];

pmodel.p11_3D = [pmodel.p11(1:2); 0];
pmodel.p21_3D = [pmodel.p21(1:2); 0];
pmodel.p31_3D = [pmodel.p31(1:2); 0];
pmodel.p41_3D = [pmodel.p41(1:2); 0];
pmodel.p51_3D = [pmodel.p51(1:2); 0];
end
