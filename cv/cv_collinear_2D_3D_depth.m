
function [s1, s2, s3] = cv_collinear_2D_3D_depth(P1, P2, P3, p1h, p2h, p3h)
P1P2_2 = sum((P1 - P2).^2);
P2P3_2 = sum((P2 - P3).^2);

a = sqrt(P1P2_2) * norm(p2h - p3h);
b = sqrt(P2P3_2) * norm(p1h - p2h);

q1 = (a / b);
q3 = (b / a);

p1h_2 = sum(p1h.^2);
p3h_2 = sum(p3h.^2);
p1p3h = dot(p1h, p3h);

P1P3 = norm(P1 - P3);

s3 = P1P3 / sqrt(q1^2*p1h_2 +      p3h_2 - 2*q1*p1p3h);
s1 = P1P3 / sqrt(     p1h_2 + q3^2*p3h_2 - 2*q3*p1p3h);
s2 = (P1P2_2 - P2P3_2 - s1^2*p1h_2 + s3^2*p3h_2) / (2*(s3*dot(p2h, p3h) - s1*dot(p1h, p2h)));
end
