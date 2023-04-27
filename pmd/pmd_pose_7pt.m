
function [R_w, t_w] = pmd_pose_7pt(P1h, P2h, ph, h_o)
Oh = pmd_origin();

cr1 = math_crossratio_2DH(ph(:, 1), ph(:, 2), ph(:, 4), ph(:, 6), h_o);
cr7 = math_crossratio_2DH(ph(:, 7), ph(:, 2), ph(:, 4), ph(:, 6), h_o);

d1 = pat_cr_to_d(P1h(:, 1), P2h(:, 1), P2h(:, 2), P2h(:, 4), P2h(:, 6), Oh, cr1);
d7 = pat_cr_to_d(P1h(:, 7), P2h(:, 7), P2h(:, 2), P2h(:, 4), P2h(:, 6), Oh, cr7);

Ah = math_interpolate(P1h(:, 1), P2h(:, 1), d1);
Eh = math_interpolate(P1h(:, 7), P2h(:, 7), d7);

Ch = cross(cross(Ah, Eh), cross(P1h(:, 4), P2h(:, 4)));
Ch = cam_xyw_to_xy1(Ch);
ch = cross(cross(ph(:, 1), ph(:, 7)), cross(ph(:, 4), h_o));
ch = cam_xyw_to_xy1(ch);

A = [Ah(1:2); 0];
C = [Ch(1:2); 0];
E = [Eh(1:2); 0];

[sa, sc, se] = cv_collinear_2D_3D_depth(A, C, E, ph(:, 1), ch, ph(:, 7));

pa = sa*ph(:, 1);
pe = se*ph(:, 7);
pc = sc*ch;

so = (sum(A.^2) - sum(E.^2) - sum(pa.^2) + sum(pe.^2)) / (2 * (dot(pe, h_o) - dot(pa, h_o)));

t_w = so * h_o;

gy = math_unit(pc - t_w);
gz = math_unit(cross(pe - pa, gy));
gx = math_unit(cross(gy, gz));

R_w = [gx, gy, gz];
end
