
function r = math_clamp(value, lb, ub)
if (value > ub), r = ub; elseif (value < lb), r = lb; else, r = value; end
end
