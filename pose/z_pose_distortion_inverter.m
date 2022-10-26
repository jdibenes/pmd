
clear all

% Variables ---------------------------------------------------------------

% Inputs
k1 = sym('k1', 'real');
k2 = sym('k2', 'real');
R  = sym('R_',  [3, 3], 'real');
t  = sym('t_',  [3, 1], 'real');
p1 = sym('p1_', [3, 1], 'real');
p2 = sym('p2_', [3, 1], 'real');
yd = sym('yd', 'real');

% Unknowns
d  = sym('d');

% Model -------------------------------------------------------------------

% yd equation 
% x  = uvs(1) / uvs(3);
% y  = uvs(2) / uvs(3);
% r2 = x^2 + y^2; % (uvs(1)^2 + uvs(2)^2)   / uvs(3)^2
% r4 = r2^2;      % (uvs(1)^2 + uvs(2)^2)^2 / uvs(3)^4
% dp = (1 + k1*r2 + k2*r4)
% dp = (1 + k1*(uvs(1)^2 + uvs(2)^2)/uvs(3)^2 + k2*(uvs(1)^2 + uvs(2)^2)^2/uvs(3)^4)
% yd = uvs(2)*(uvs(3)^4 + k1*(uvs(1)^2 + uvs(2)^2)*uvs(3)^2 + k2*(uvs(1)^2 + uvs(2)^2)^2) / uvs(3)^5

% yd polynomial
% 0 = yd*uvs(3)^5 - uvs(2)*(uvs(3)^4 + k1*(uvs(1)^2 + uvs(2)^2)*uvs(3)^2 + k2*(uvs(1)^2 + uvs(2)^2)^2)

% xd equation
% xd = uvs(1)*(usv(3)^4 + k1*(usv(1)^2 + usv(2)^2)*usv(3)^2 + k2*(usv(1)^2 + usv(2)^2)^2) / usv(3)^5

uvs = cam_transform(R, t, math_interpolate(p1, p2, d));

eq_yd = yd*(uvs(3)^5) - uvs(2)*((uvs(3)^4) + k1*((uvs(1)^2) + (uvs(2)^2))*(uvs(3)^2) + k2*(((uvs(1)^2) + (uvs(2)^2))^2));
eq_yd = collect(simplify(collect(simplify(eq_yd), d)), d);

list_yd = children(eq_yd);
n = numel(list_yd);
cof_yd = sym([]);

for k = 1:n, cof_yd(k) = list_yd(k) / (d^(n - k)); end

xd = (uvs(1)*((uvs(3)^4) + k1*((uvs(1)^2) + (uvs(2)^2))*(uvs(3)^2) + k2*(((uvs(1)^2) + (uvs(2)^2))^2))) / (uvs(3)^5);

% Maps --------------------------------------------------------------------

matlabFunction(cof_yd, 'Vars', {k1; k2; R; t; p1; p2; yd}, 'File', 'pose_d_quintic.m');
matlabFunction(xd,     'Vars', {k1; k2; R; t; p1; p2; d},  'File', 'pose_d_to_xd.m');
