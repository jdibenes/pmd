
function p2dn = cam_backproject(K, p2d)
p2dn = K \ cam_xy_to_xy1(p2d);
end
