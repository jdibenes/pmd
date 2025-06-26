
function Q = poly_monomial_matrix(cofmon, monomials)
N = size(cofmon, 1);
M = numel(monomials);
Q = sym(zeros(N, M));

for col = 1:M
    sel = monomials(col);
for row = 1:N
    cof = cofmon{row, 1};
    mon = cofmon{row, 2};

    index = has(simplify(mon == sel), symtrue);
    assert(sum(index) <= 1);
    if (any(index)), Q(row, col) = cof(index); end
end 
end    
end
