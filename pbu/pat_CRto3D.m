
function pat = pat_CRto3D(pmodel, pat)
pat.A = pmodel.f1(pat.R1, pat.R5);
pat.B = pmodel.f2(pat.R1, pat.R5);
pat.C = pmodel.f3(pat.R1, pat.R5);
pat.D = pmodel.f4(pat.R1, pat.R5);
pat.E = pmodel.f5(pat.R1, pat.R5);
end
