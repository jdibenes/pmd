
function [R2_g, t2_g] = pose_transform2(R, t, R2, t2)
R2_g = R * R2;
t2_g = R * t2 + t;
end
