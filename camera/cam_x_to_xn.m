
function xn = cam_x_to_xn(K, x)
xn = (x - K(1, 3)) / K(1, 1);
end
