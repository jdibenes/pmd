
function m = math_minor(M, row, col)
rows = size(M, 1);
cols = size(M, 2);

r = [1:(row - 1), (row + 1):rows];
c = [1:(col - 1), (col + 1):cols];

m = M(r, c);
end
