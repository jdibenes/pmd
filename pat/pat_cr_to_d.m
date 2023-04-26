
function d = pat_cr_to_d(A1h, A2h, Bh, Ch, Dh, Oh, cr)
v = cr*det([Bh, Dh, Oh])/det([Bh, Ch, Oh])*cross(Ch, Oh) - cross(Dh, Oh);
d = dot(v, A1h) / dot(v, A1h - A2h);
end
