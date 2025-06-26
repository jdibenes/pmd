
function y = cam_yn_to_y(K, yn)
y = (yn * K(2, 2)) + K(2, 3);
end
