
function R = pose_random_R_axis(axis)
R = axang2rotm([axis(:).', 2*pi*rand()]);
end
