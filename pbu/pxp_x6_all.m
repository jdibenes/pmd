
function [R, t] = pxp_x6_all(R2, t2, pat1, pat2)
X1 = pxp_distance_collinear(pat1.A, pat1.C, pat1.E, pat1.na, pat1.nc, pat1.ne);

s1a = X1(1) * norm(pat1.na);
s1e = X1(2) * norm(pat1.ne);

AE = pat1.E - pat1.A;
t1 = ((s1a^2 - s1e^2) / sum(AE.^2) + 1) / 2;

center = pat1.A + t1 * AE;
radius = sqrt(s1a^2 - sum((t1 * AE).^2));

yscale = sqrt(1 - dot(pat1.fa, pat1.fe)^2);

gz_p = [0; 0; 1];
gx_p = math_unit(AE);
gy_p = cross(gz_p, gx_p);

R_p = radius * [gx_p, gy_p, gz_p];

gx_c = pat1.fa;
gy_c = cross(gx_c, pat1.fe) / yscale;
gz_c = cross(gx_c, gy_c);

R_c = [gx_c, gy_c, gz_c];

%

X   = sym('X',   'real');
s2a = sym('s2a', 'real');

x_t6 = R_p * [0; (2 * X) ; -(X^2 - 1)] / (X^2 + 1) + center;

gx_w = (pat1.A - x_t6) / s1a;
gy_w = cross(gx_w, pat1.E - x_t6) / (s1e * yscale);
gz_w = cross(gx_w, gy_w);

x_R6 = [gx_w, gy_w, gz_w] * R_c.';

p = (x_R6 * (s2a * R2 * pat2.fa + t2) + x_t6);

eq_x = solve(p(1) == pat1.A(1), s2a);
eq_z = solve(p(3) == 0,         s2a);

eq = numden(eq_x - eq_z);

%

list_X = children(collect(eq, X));

base = polynomialDegree(eq, X) + 1;
coefficients = sym(zeros(1, base));

for monomial = list_X
    d = polynomialDegree(monomial, X);
    coefficients(base - d) = monomial / (X ^ d);
end

X_solutions = roots(eval(coefficients));

N = numel(X_solutions);

R = zeros(3, 3, N);
t = zeros(3, N);

for k = 1:N
    X_value = real(X_solutions(k));
    R(:, :, k) = eval(subs(x_R6, X, X_value));
    t(:, k) = eval(subs(x_t6, X, X_value));
end
end
