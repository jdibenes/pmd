
function [R, d] = math_R_cayley(qx, qy, qz)
R = [1 + qx^2 - qy^2 - qz^2, 2*qx*qy - 2*qz, 2*qx*qz + 2*qy;
     2*qx*qy + 2*qz, 1 - qx^2 + qy^2 - qz^2, 2*qy*qz - 2*qx;
     2*qx*qz - 2*qy, 2*qy*qz + 2*qx, 1 - qx^2 - qy^2 + qz^2];
d = (1 + qx^2 + qy^2 + qz^2);
end
