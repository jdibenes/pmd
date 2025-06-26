
function cofmon = poly_monomial_extract(polynomials, variables)
N = numel(polynomials);
cofmon = cell(N, 2);
for k = 1:N, [cofmon{k, 1}, cofmon{k, 2}] = coeffs(polynomials(k), variables);end
end
