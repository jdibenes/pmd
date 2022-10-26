
function [R, t, d, P, xyn, s, xdn, ydn, user] = pose_unpack(data)
[sz_fixed, sz_line, sz_R, sz_t, sz_d, sz_P, sz_xy, sz_s, sz_xdn, sz_ydn, sz_ext] = pose_packet_size();
lines = pose_packet_lines(sz_fixed, sz_line, data(end, 1), size(data, 1));

ofs_R    = 1;
ofs_t    = ofs_R   +  sz_R;
ofs_d    = ofs_t   +  sz_t;
ofs_P    = ofs_d   + (sz_d   * lines);
ofs_xy   = ofs_P   + (sz_P   * lines);
ofs_s    = ofs_xy  + (sz_xy  * lines);
ofs_xdn  = ofs_s   + (sz_s   * lines);
ofs_ydn  = ofs_xdn + (sz_xdn * lines);
ofs_user = ofs_ydn +  sz_ydn;

R    = data(ofs_R    : (ofs_t   - 1),      :);
t    = data(ofs_t    : (ofs_d   - 1),      :);
d    = data(ofs_d    : (ofs_P   - 1),      :);
P    = data(ofs_P    : (ofs_xy  - 1),      :);
xyn  = data(ofs_xy   : (ofs_s   - 1),      :);
s    = data(ofs_s    : (ofs_xdn - 1),      :);
xdn  = data(ofs_xdn  : (ofs_ydn - 1),      :);
ydn  = data(ofs_ydn,                       :);
user = data(ofs_user : (end     - sz_ext), :);

if (size(data, 2) > 1), return; end

sz_Rs = sqrt(sz_R);

R    = reshape(R,   [sz_Rs,  sz_Rs]);
t    = reshape(t,   [sz_t,   1]);
d    = reshape(d,   [sz_d,   lines]);
P    = reshape(P,   [sz_P,   lines]);
xyn  = reshape(xyn, [sz_xy,  lines]);
s    = reshape(s,   [sz_s,   lines]);
xdn  = reshape(xdn, [sz_xdn, lines]);
ydn  = reshape(ydn, [sz_ydn, 1]);
end
