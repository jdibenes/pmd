
function p = cam_project(K, R, t, P)
p = K * cam_transform(R, t, P);
end
