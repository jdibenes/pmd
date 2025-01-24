
function R = pxp_R_lines(QY1, QY2, QXY1, PY1, PY2)
y = math_unit((QY1 - QY2) / (PY1(2) - PY2(2)));
xy = QXY1 - QY1;
z = math_unit(cross(xy, y));
x = cross(y, z);
R = [x, y, z].';
end
