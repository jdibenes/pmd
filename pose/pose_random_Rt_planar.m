
function [R, t, r] = pose_random_Rt_planar(scale, model)
R = pose_random_R_axis([0; 1; 0]);
r = rotm2axang(R);
axis = r(1:3);
angle = sign(axis(2))*r(4);

switch (model)
case 'ackermann', t = scale*rand()*[cos(angle/2); 0; -sin(angle/2)];
case 'general',   t = pose_random_t_plane(pose_plane_basis(axis), scale, [0;0;0]);
otherwise,        error('Unknown mode');
end
end
