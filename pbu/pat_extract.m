
function pat = pat_extract(pmodel, K, pat)
pat = pat_2Dtof(K, pat);
pat = pat_1DtoCR(pat);
pat = pat_CRto3D(pmodel, pat);
end
