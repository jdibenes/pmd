
function [pat1, pat2] = pat_extract_stereo(pmodel, K1, K2, pat1, pat2)
pat1 = pat_extract(pmodel, K1, pat1);
pat2 = pat_extract(pmodel, K2, pat2);
end
