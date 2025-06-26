
function [f, n] = math_unit(v)
n = norm(v);
if (n ~= 0), f = v / n; else, f = zeros(size(v)); end
end
