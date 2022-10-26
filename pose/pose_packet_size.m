
function [sz_fixed, sz_line, sz_R, sz_t, sz_d, sz_P, sz_xyn, sz_s, sz_xdn, sz_ydn, sz_ext] = pose_packet_size()
sz_R   = 9;
sz_t   = 3;
sz_d   = 1;
sz_P   = 3;
sz_xyn = 2;
sz_s   = 1;
sz_xdn = 1;
sz_ydn = 1;
sz_ext = 1;

sz_fixed = sz_R + sz_t + sz_ydn + sz_ext;
sz_line  = sz_d + sz_P + sz_xyn + sz_s + sz_xdn;
end
