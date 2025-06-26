
function [reprojection_errors, valid_index] = cam_reproject_validate_stereo(P0, P1, p3d, p2d0, p2d1)
[re0, vi0] = cam_reproject_validate(P0, p3d, p2d0);
[re1, vi1] = cam_reproject_validate(P1, p3d, p2d1);

reprojection_errors = (re0 + re1) / 2;
valid_index = vi0 & vi1;
end
