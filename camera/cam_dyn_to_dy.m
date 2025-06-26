
function dy = cam_dyn_to_dy(K, dyn)
dy = K(2, 2) * dyn;
end
