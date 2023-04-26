
function [x] = pat_border(f, box, width, color, linewidth)
figure(f);

minx = box(1);
miny = box(2);
maxx = box(3);
maxy = box(4);

height = maxy - miny;

l = [minx, miny, width, height]; 
r = [maxx, miny, width, height];

for c = color
l(1) = l(1) - width;
rectangle('Position', l, 'FaceColor', c, 'EdgeColor', c, 'LineWidth', linewidth);
rectangle('Position', r, 'FaceColor', c, 'EdgeColor', c, 'LineWidth', linewidth);
r(1) = r(1) + width;
end

x = [l(1), r(1)];
xlim(x);
end
