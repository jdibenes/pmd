
function h_o = pmd_homography_h2xyw(H)
h_o = H \ [0; 0; 1];
end
