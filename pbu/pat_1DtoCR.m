
function pat = pat_1DtoCR(pat)
pat.R1 = pat_crossratio(pat.a, pat.b, pat.c, pat.d);
pat.R5 = pat_crossratio(pat.e, pat.d, pat.c, pat.b);
end
