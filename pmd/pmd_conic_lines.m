
function [line1, line2, line3] = pmd_conic_lines(pb, pm6, pc, pm7, pd, cr1, cr2)
line1 = det([pb,pc,pd])*cr1*cr2*cross(pm6,pm7) - det([pb,pm7,pd])*cr2*cross(pm6,pc) + det([pb,pc,pm7])*(1 - cr1 - cr2)*cross(pm6,pd);
line2 = det([pb,pm6,pd])*cross(pc,pm7) - det([pb,pm6,pm7])*cr2*cross(pc,pd) + det([pm6,pm7,pd])*(1 - cr1)*cross(pc,pb);
line3 = det([pb,pc,pd])*cr1*cr2*cross(pm7,pm6) - det([pb,pm6,pd])*cr1*cross(pm7,pc) + det([pm6,pc,pd])*(1 - cr1 - cr2)*cross(pm7,pb);
end
