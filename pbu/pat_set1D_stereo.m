
function [pat1, pat2] = pat_set1D_stereo(pat1, pat2, u)
pat1 = pat_set1D(pat1, u(1:5));
pat2 = pat_set1D(pat2, u(6:10));
end
