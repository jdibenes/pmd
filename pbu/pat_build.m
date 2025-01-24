
function T = pat_build(C1, C2, C3, C4, R)
C1 = simplify(C1 - C3);
RL = -C1.';
T = R == simplifyFraction(pat_crossratio(simplify(RL * C1), simplify(RL * simplify(C2 - C3)), 0, simplify(RL * simplify(C4 - C3))));
end
