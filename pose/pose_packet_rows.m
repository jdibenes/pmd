
function rows = pose_packet_rows(sz_fixed, sz_line, lines, sz_user)
rows = sz_fixed + (sz_line * lines) + sz_user;
end
