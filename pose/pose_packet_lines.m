
function lines = pose_packet_lines(sz_fixed, sz_line, sz_user, sz_packet)
lines = (sz_packet - (sz_fixed + sz_user)) / sz_line;
end
