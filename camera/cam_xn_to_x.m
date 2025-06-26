
function x = cam_xn_to_x(K, xn)
x = (xn * K(1, 1)) + K(1, 3);
end
