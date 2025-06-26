
function order = poly_compare_reverse_lexicographic(ed, k1, k2)
d = ed(k1, 1:(end-1)) - ed(k2, 1:(end-1));
index = find(d, 1, 'last');
if (isempty(index)), order = 0; else, order = sign(d(index)); end
end
