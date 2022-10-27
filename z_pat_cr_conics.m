
clear all

P2_x = [-1, -0.75, -0.5, -0.25, 0, 0.25, 0.5, 0.75, 1];
P1_x = [-1, -0.75,  0,    0,    0, 0,    0,   0.75, 1];

p1 = [sym('p1_', [2, 1], 'real'); 1];
p2 = [sym('p2_', [2, 1], 'real'); 1];
p3 = [sym('p3_', [2, 1], 'real'); 1];
p4 = [sym('p4_', [2, 1], 'real'); 1];
p5 = [sym('p5_', [2, 1], 'real'); 1];
p6 = [sym('p6_', [2, 1], 'real'); 1];

d1 = sym('d1', 'real'); 

cr1_v = pat_d_to_cr(P2_x(2), P2_x(3), P2_x(4), P2_x(5), d1);
cr1 = cr1_v(1) / cr1_v(2);
cr2 = math_crossratio_1D(P2_x(3), P2_x(4), P2_x(5), P2_x(6));
cr3 = math_crossratio_1D(P2_x(4), P2_x(5), P2_x(6), P2_x(7));

[l1_1, l2_1, l3_1] = pmd_conic_lines(p1, p2, p3, p4, p5, cr1, cr2);
[l1_2, l2_2, l3_2] = pmd_conic_lines(p2, p3, p4, p5, p6, cr2, cr2);

ho1 = cross(l1_1, l3_1);
ho2 = cross(l1_2, l3_2);

con = cross(ho1, ho2);
