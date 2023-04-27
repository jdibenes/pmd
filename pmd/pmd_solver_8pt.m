
function [R_w, t_w, H, s] = pmd_solver_8pt(P1h, P2h, ph, lh)
[H, s] = cv_H_points_to_lines(ph, lh);
h_o = pmd_origin_projection_H(H);
h_o = cam_xyw_to_xy1(h_o);
[R_w, t_w] = pmd_pose_7pt(P1h, P2h, ph, h_o);
end
