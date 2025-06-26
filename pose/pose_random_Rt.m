
function [R, t] = pose_random_Rt(scale, offset)
R = pose_random_R();
t = pose_random_t(scale, offset);
end
