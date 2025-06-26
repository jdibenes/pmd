
function dyn = cam_dy_to_dyn(K, dy)
dyn = dy / K(2, 2);
end
