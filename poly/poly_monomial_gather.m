
function monomials = poly_monomial_gather(cofmon)
monomials = [];
N = size(cofmon, 1);
for k = 1:N, monomials = union(monomials, cofmon{k, 2}); end
end
