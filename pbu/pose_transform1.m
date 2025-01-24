
function [R_w, t_w] = pose_transform1(R, t)
R_w = R.';
t_w = -R_w*t;
end
