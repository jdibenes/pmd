
function [R, t, d, P, xyn, s, xdn, ok] = pose_generate_row(k1, k2, scale, offset, P1, P2, ydn, options)
ok = -1;
while (ok ~= 0)    
[R, t] = pose_random_Rt(scale, offset);
if (R(3, 3) > 0), R = R*[0, 1, 0; 1, 0, 0; 0, 0, -1]; end
C = -R.'*t;
if (C(3) < 0), t = -t; end
[ok, d, P, xyn, s, xdn] = pose_generate_full(k1, k2, R, t, P1, P2, ydn, options);
end
end
