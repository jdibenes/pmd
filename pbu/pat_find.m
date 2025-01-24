
function [u, z, P] = pat_find(K, R, T, P1, n, row)
v = K(2, 2) * R(:, 2) + (K(2, 3) - row) * R(:, 3);
d = P1 - T;
t = -dot(v, d) / dot(v, n) * n;
Q = d + t;
P = P1 + t;
z = dot(R(:, 3), Q);
u = (K(1, 1) * dot(R(:, 1), Q)) / z + K(1, 3); 
end
