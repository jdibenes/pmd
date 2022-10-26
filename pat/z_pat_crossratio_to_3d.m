
clear all

y1 = sym('y1', 'real');
y2 = sym('y2', 'real');

P1h_1 = [sym('P1_1_x', 'real'); y1; 1];
P2h_1 = [sym('P2_1_x', 'real'); y1; 1];
P3h_1 = [sym('P3_1_x', 'real'); y1; 1];
P4h_1 = [sym('P4_1_x', 'real'); y1; 1];
P5h_1 = [sym('P5_1_x', 'real'); y1; 1];

P1h_2 = [sym('P1_2_x', 'real'); y2; 1];
P2h_2 = [sym('P2_2_x', 'real'); y2; 1];
P3h_2 = [sym('P3_2_x', 'real'); y2; 1];
P4h_2 = [sym('P4_2_x', 'real'); y2; 1];
P5h_2 = [sym('P5_2_x', 'real'); y2; 1];

d1 = sym('d1', 'real');
d5 = sym('d5', 'real');

P1h = P1h_1 + d1*(P1h_2 - P1h_1);
P5h = P5h_1 + d5*(P5h_2 - P5h_1);

l0 = cross(P1h,   P5h);
l2 = cross(P2h_1, P2h_2);
l3 = cross(P3h_1, P3h_2);
l4 = cross(P4h_1, P4h_2);

p1 = simplify(P1h);
p2 = simplify(cross(l0, l2));
p3 = simplify(cross(l0, l3));
p4 = simplify(cross(l0, l4));
p5 = simplify(P5h);

p1 = simplify(p1 / p1(3));
p2 = simplify(p2 / p2(3));
p3 = simplify(p3 / p3(3));
p4 = simplify(p4 / p4(3));
p5 = simplify(p5 / p5(3));

cr1 = sym('cr1', 'real');
cr5 = sym('cr5', 'real');

cr1_l = math_crossratio_2D(p1(1:2, :), p2(1:2, :), p3(1:2, :), p4(1:2, :));
cr5_l = math_crossratio_2D(p2(1:2, :), p3(1:2, :), p4(1:2, :), p5(1:2, :));

[cr1_num, cr1_den] = numden(cr1_l);
[cr5_num, cr5_den] = numden(cr5_l);

eq1 = cr1*cr1_den - cr1_num;
eq5 = cr5*cr5_den - cr5_num;

sol = solve([eq1, eq5], [d1, d5]);

%matlabFunction(sol_d, 'File', 'pat_cr_to_d.m');
