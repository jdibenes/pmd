
function t = pose_random_t_plane(basis, scale, offset)
a = 2*pi*rand();
t = sqrt(rand()) * (cos(a)*basis(:, 1) + sin(a)*basis(:, 2)) * scale + offset;
end
