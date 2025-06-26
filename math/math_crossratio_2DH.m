
function r = math_crossratio_2DH(pa, pb, pc, pd, po)
r = (det([pa, pd, po])*det([pb, pc, po])) / (det([pa, pc, po])*det([pb, pd, po]));
end
