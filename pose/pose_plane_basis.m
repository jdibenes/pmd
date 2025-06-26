
function basis = pose_plane_basis(normal)
[~, ~, V] = svd(normal(:).');
basis = V(:, 2:3);
end
