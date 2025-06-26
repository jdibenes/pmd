
function L = math_pluecker_lines(P1, P2)
d = P2 - P1;
n = vecnorm(d, 2);
if (any(n == 0)), error('P1 and P2 coincide'); end
q = d ./ n;
L = [q; cross(q, P1)];
end
