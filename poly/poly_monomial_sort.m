
function I = poly_monomial_sort(exponents, monomial_order)
if (isempty(monomial_order)), return; end

switch (monomial_order)
case 'degreeInverseLexicographic', f = @poly_compare_graded_reverse_lexicographic;
case 'degreeLexicographic',        f = @poly_compare_graded_lexicographic;
case 'lexicographic',              f = @poly_compare_lexicographic;
case 'reverseLexicographic',       f = @poly_compare_reverse_lexicographic;
end

I = fliplr(quicksort(exponents, f));
end
