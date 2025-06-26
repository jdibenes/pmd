
function order = poly_compare_graded_lexicographic(ed, k1, k2)
if     (ed(k1, end) > ed(k2, end)), order =  1;
elseif (ed(k1, end) < ed(k2, end)), order = -1;
else,  order = poly_compare_lexicographic(ed, k1, k2);
end
end
