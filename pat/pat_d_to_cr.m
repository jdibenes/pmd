
function cr = pat_d_to_cr(A1h, A2h, Bh, Ch, Dh, Oh, d)
Ah = (1 - d) * A1h + d * A2h;
cr = (det([Ah, Dh, Oh]) * det([Bh, Ch, Oh])) / (det([Ah, Ch, Oh]) * det([Bh, Dh, Oh]));
end
