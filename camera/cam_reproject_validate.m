
function [reprojection_errors, valid_index] = cam_reproject_validate(P, p3d, p2d)
h2d = P * cam_XYZ_to_XYZ1(p3d);
reprojection_errors = vecnorm(p2d - cam_xy1_to_xy(cam_xyw_to_xy1(h2d)));
valid_index = h2d(3, :) > 0;
end
