
function [R, t] = pxp_x6(R2, t2, pat1, pat2)
[R_all, t_all] = pxp_x6_all(R2, t2, pat1, pat2);
[R, t] = pxp_select(R_all, t_all, R2, t2, pat2.ne, pat2.E);
end
