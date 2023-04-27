
function cr = pat_d_to_cr(A1h, A2h, Bh, Ch, Dh, Oh, d)
Ah = math_interpolate(A1h, A2h, d);
cr = (det([Ah, Dh, Oh]) * det([Bh, Ch, Oh])) / (det([Ah, Ch, Oh]) * det([Bh, Dh, Oh]));
end
