
function v = pose_random_t(scale, offset)
v = (math_unit(randn(3, 1)) * (rand()^(1/3)) * scale) + offset;
end
