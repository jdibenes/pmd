
clear all

p_list = sym(zeros(3, 5));
l_list = sym(zeros(3, 5));

for k = 1:5
p_list(:, k) = [sym(['p' num2str(k) '_'], [2, 1]); 1];
l_list(:, k) = sym(['l' num2str(k) '_'], [3, 1]); 
end

k = sym('k', [3, 1]); 
[R, d] = math_R_cayley(k(1), k(2), k(3));
t = sym('t', [3, 1]);
T = [zeros(3, 2), t];

left = l_list(:, 1).'*R*p_list(:, 1);
right = (l_list(:, 1).'*T*p_list(:, 1))*d;

eq = left - right;
eq = collect(expand(eq), k);
eq_t = collect(expand(eq), t);

cof = children(eq);