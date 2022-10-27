
clear all

y1 = 0;
y2 = sym('y2', 'real');

P1h_2 = [sym('P1_2_x', 'real'); y2; 1];
P2h_2 = [sym('P2_2_x', 'real'); y2; 1];
P3h_2 = [sym('P3_2_x', 'real'); y2; 1];
P4h_2 = [sym('P4_2_x', 'real'); y2; 1];

P1h_1 = [0;        y1; 1];
P2h_1 = [P2h_2(1); y1; 1];
P3h_1 = [P3h_2(1); y1; 1];
P4h_1 = [P4h_2(1); y1; 1];

d1 = sym('d1', 'real');

P1h = P1h_1 + d1*(P1h_2 - P1h_1);
P1x = P1h + [1; 0; 0];

l0 = cross(P1h,   P1x);
l2 = cross(P2h_1, P2h_2);
l3 = cross(P3h_1, P3h_2);
l4 = cross(P4h_1, P4h_2);

p1 = simplify(P1h);
p2 = simplify(cross(l0, l2));
p3 = simplify(cross(l0, l3));
p4 = simplify(cross(l0, l4));

p1 = simplify(p1 / p1(3));
p2 = simplify(p2 / p2(3));
p3 = simplify(p3 / p3(3));
p4 = simplify(p4 / p4(3));

cr1 = sym('cr1', 'real');

cr1_l = math_crossratio_2D(p1(1:2, :), p2(1:2, :), p3(1:2, :), p4(1:2, :));
cr1_l = simplify(cr1_l);

[cr1_num, cr1_den] = numden(cr1_l);

eq1 = cr1*cr1_den - cr1_num;

sol = solve(eq1, d1);
sol = simplify(sol);

matlabFunction([cr1_num, cr1_den], 'File', 'pat_v_d_to_cr.m');
matlabFunction(sol, 'File', 'pat_v_cr_to_d.m');
