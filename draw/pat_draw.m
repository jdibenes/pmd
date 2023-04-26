
function f = pat_draw(pmodel, box_x, box_y, blocksize, iterations, size)
f = figure();

hold on
f.GraphicsSmoothing = 'off';
plot(0, 0, '.w');
xlim(box_x);
ylim(box_y);
set(gca, 'DataAspectRatio', [1 1 1], 'PlotBoxAspectRatio',[1 1 1], 'Position', [0, 0, 1, 1]);
rectangle('Position', [box_x(1), box_y(1), box_x(2) - box_x(1), box_y(2) - box_y(1)], 'FaceColor', 'w', 'EdgeColor', 'w', 'LineWidth', size);

B = zeros(blocksize, 2);
idx = 1;
k = 0;

while (k < iterations)
    p = randpoint(box_x, box_y);
    c = color(pmodel, p);
    if (c == 1), continue; end
    B(idx, :) = p;
    idx = idx + 1;
    if (idx <= blocksize), continue; end
    idx = 1;
    k = k + 1;
    plot(B(:, 1), B(:, 2), '.k', 'MarkerSize', size);
    drawnow
end
end

function p = randpoint(x, y)
p = [x(1) + rand() * (x(2) - x(1)); y(1) + rand() * (y(2) - y(1))];
end

function l = left(p1, p2, p)
l = sign((p2(1) - p1(1)) * (p(2) - p1(2)) - (p2(2) - p1(2)) * (p(1) - p1(1)));
end

function c = color(pmodel, p)
c = false;
for k = 1:pmodel.lines, c = xor(c, left(pmodel.p2(k, :), pmodel.p1(k, :), p) < 0); end
end
