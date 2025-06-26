
function h_q = math_find_closest_point(h_l, h_p)
h12 = abs(h_l(1:2));

if (h12(1) == 0 && h12(2) == 0), h_q = [0; 0; 0]; return; end

[~, path] = max(h12);

h1 = h_l(1);
h2 = h_l(2);
h3 = h_l(3);
p1 = h_p(1);
p2 = h_p(2);

h1_2 = h1^2;
h2_2 = h2^2;

switch (path)
case 1, y = (p2 - ((h2 * h3) / h1_2) - ((h2 / h1) * p1)) / ((h2_2 / h1_2) + 1); x = -(h2*y + h3) / h1; w = 1;
case 2, x = (p1 - ((h1 * h3) / h2_2) - ((h1 / h2) * p2)) / ((h1_2 / h2_2) + 1); y = -(h1*x + h3) / h2; w = 1;
end

h_q = [x; y; w];
end
