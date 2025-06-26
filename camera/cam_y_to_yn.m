
function yn = cam_y_to_yn(K, y)
yn = (y - K(2, 3)) / K(2, 2);
end
