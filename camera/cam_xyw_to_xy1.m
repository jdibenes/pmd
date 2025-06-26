
function xy1 = cam_xyw_to_xy1(xyw)
xy1 = xyw ./ xyw(3, :);
end
