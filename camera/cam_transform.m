
function p = cam_transform(R, t, P)
p = (R * P) + t;
end
