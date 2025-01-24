
function [R, t] = pxp_v2(R2, t2, pat1, pat2)
X1 = pxp_distance_collinear(pat1.A, pat1.C, pat1.E, pat1.na, pat1.nc, pat1.ne);
X2 = pxp_distance_collinear(pat2.A, pat2.C, pat2.E, pat2.na, pat2.nc, pat2.ne);

pA1 = X1(1) * pat1.na;
pA2 = X2(1) * R2 * pat2.na + t2;
pE1 = X1(2) * pat1.ne;

R = pxp_R_lines(pA1, pA2, pE1, pat1.A, pat2.A);
t = pxp_t_equation(R, pA1, pat1.A);
end
