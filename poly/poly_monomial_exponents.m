
function e = poly_monomial_exponents(monomials, variables)
N = numel(monomials);
M = numel(variables);
e = zeros(N, M);

for n = 1:N
for m = 1:M
    e(n, m) = polynomialDegree(monomials(n), variables(m));
end
end

e = [e, sum(e, 2)];
end
