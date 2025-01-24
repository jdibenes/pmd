
function x = pxp_distance_collinear(P1, P2, P3, n1, n2, n3)
d13    = norm(P1 - P3);
d12n23 = norm(P1 - P2) * abs(n2(1) - n3(1));
d23n12 = norm(P2 - P3) * abs(n1(1) - n2(1));

base = d13 / norm(d12n23 * n1 - d23n12 * n3);

x = [d12n23; d23n12] * base;
end
