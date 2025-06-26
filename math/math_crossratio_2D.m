
function cr = math_crossratio_2D(pa, pb, pc, pd)
cr = (det([pa, pd])*det([pb, pc])) / (det([pa, pc])*det([pb, pd]));
end
