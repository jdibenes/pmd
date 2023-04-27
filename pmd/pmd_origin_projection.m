
function [h_o, cr1, cr5, l1, l2, l3]  = pmd_origin_projection(Ph, ph)
Oh = pmd_origin();

cr1 = math_crossratio_2DH(Ph(:, 1), Ph(:, 2), Ph(:, 3), Ph(:, 4), Oh);
cr5 = math_crossratio_2DH(Ph(:, 2), Ph(:, 3), Ph(:, 4), Ph(:, 5), Oh);

[l1, l2, l3] = pmd_conic_lines(ph(:, 1), ph(:, 2), ph(:, 3), ph(:, 4), ph(:, 5), cr1, cr5);

h_o = cross(l1, l3);
end
