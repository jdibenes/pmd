
function R = math_axisangle_to_R(k, theta)
K = math_v3_to_ssm(k);
R = eye(3) + sin(theta)*K + (1 - cos(theta))*(K^2);
end
