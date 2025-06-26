
function [Q, monomials] = poly_equations_to_matrix(polynomials, variables, monomial_order)
cofmon    = poly_monomial_extract(polynomials, variables);
monomials = poly_monomial_gather(cofmon);
exponents = poly_monomial_exponents(monomials, variables);
I         = poly_monomial_sort(exponents, monomial_order);
monomials = monomials(I);
Q         = poly_monomial_matrix(cofmon, monomials);
end
