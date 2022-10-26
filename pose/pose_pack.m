
function data = pose_pack(R, t, d, P, xyn, s, xdn, ydn, user)
data = [R(:); t(:); d(:); P(:); xyn(:); s(:); xdn(:); ydn; user(:); numel(user)];
end
