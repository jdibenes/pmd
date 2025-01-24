
function pat = pat_2Dtof(K, pat)
pat.pa = [pat.a; pat.row; 1];
pat.pb = [pat.b; pat.row; 1];
pat.pc = [pat.c; pat.row; 1];
pat.pd = [pat.d; pat.row; 1];
pat.pe = [pat.e; pat.row; 1];

pat.na = K \ pat.pa;
pat.nb = K \ pat.pb;
pat.nc = K \ pat.pc;
pat.nd = K \ pat.pd;
pat.ne = K \ pat.pe;

[pat.fa, pat.la] = math_unit(pat.na);
[pat.fb, pat.lb] = math_unit(pat.nb);
[pat.fc, pat.lc] = math_unit(pat.nc);
[pat.fd, pat.ld] = math_unit(pat.nd);
[pat.fe, pat.le] = math_unit(pat.ne);
end
