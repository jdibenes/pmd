
function [R_w, t_w] = pmd_solver_7pt(P1h, P2h, ph)
h_o = pmd_origin_projection(P2h(:, 2:6), ph(:, 2:6));
h_o = cam_xyw_to_xy1(h_o);
[R_w, t_w] = pmd_pose_7pt(P1h, P2h, ph, h_o);
end
