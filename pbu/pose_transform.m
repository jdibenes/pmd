
function p = pose_transform(R, t, P)
p = R * P + t;
end
