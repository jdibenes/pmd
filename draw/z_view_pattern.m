
clear all

% Settings ----------------------------------------------------------------

min_y = 0;
max_y = 2;

P2_x = [-1, -1, -0.5, 0, 0.5, 1, 1];
P1_x = [-1,  0,    0, 0,   0, 0, 1];

pad = 0.5;

bsize = 10000;
iter = 10000;

border_colors = ['r', 'g', 'b'];
linewidth = 0.1;

% -------------------------------------------------------------------------

N = numel(P2_x);
pmodel.p2 = [P2_x.', ones([N, 1])*max_y];
pmodel.p1 = [P1_x.', ones([N, 1])*min_y];
pmodel.lines = N;

f = pat_draw(pmodel, [-1 - pad, 1 + pad], [min_y, max_y], bsize, iter, 1);
%pat_border(f, [-1 - pad, min_y, 1 + pad, max_y], pad, border_colors, linewidth);
