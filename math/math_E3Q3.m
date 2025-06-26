
% Monomial order
% x2
% xy
% xz
% x
% y2
% yz
% y
% z2
% z
% 1
% DOES NOT HANDLE DEGENERATE CASES (see supplementary)
function XYZ = math_E3Q3(q)
x2 = q(:,  1);
xy = q(:,  2);
xz = q(:,  3);
x  = q(:,  4);

y2 = q(:,  5);
yz = q(:,  6);
z2 = q(:,  8);

y  = q(:,  7);
z  = q(:,  9);
c  = q(:, 10);

n0 = zeros(3, 1);

A = -[y2, z2, yz];

P_x0 = [ y,  z, c];
P_x1 = [xy, xz, x];
P_x2 = [n0, n0, x2];

AmP_x0 = A \ P_x0;
AmP_x1 = A \ P_x1;
AmP_x2 = A \ P_x2;

AmP = cat(3, AmP_x2, AmP_x1, AmP_x0); % eq 5

y2 = AmP(1, :, :); % x only [y; z; 1]
z2 = AmP(2, :, :); % x only [y; z; 1]
yz = AmP(3, :, :); % x only [y; z; 1]

% 1  2  3  4  5  6
% y2 yz y  z2 z  1

z_mul = [2, 4, 5]; % z * [y; z; 1] = [yz; z2; z]
y_mul = [1, 2, 3]; % y * [y; z; 1] = [y2; yz; y]

M1 = zeros(3, 6, 5);

% y2*z - yz*y
M1(1, z_mul, 3:5) = y2;
M1(1, y_mul, 3:5) = M1(1, y_mul, 3:5) - yz;

% yz*z  - z2*y
M1(2, z_mul, 3:5) = yz;
M1(2, y_mul, 3:5) = M1(2, y_mul, 3:5) - z2;

%      y  z  1
mul = [1, 2, 3;  % y
       2, 4, 5;  % z
       3, 5, 6]; % 1

% yz*yz - y2*z2
for var1 = 1:3
for var2 = 1:3
    lx1 = yz(1, var1, :);
    lx2 = yz(1, var2, :);
    rx1 = y2(1, var1, :);
    rx2 = z2(1, var2, :);
    idx = mul(var1, var2);
    d1 = conv(lx1(:), lx2(:));
    d2 = conv(rx1(:), rx2(:));
    d12 = reshape(d1 - d2, 1, 1, 5);    
    M1(3, idx, :) = M1(3, idx, :) + d12; 
end
end

% 1  2  3  4  5  6
% y2 yz y  z2 z  1

y2_cof = M1(:, 1, :);
yz_cof = M1(:, 2, :);
z2_cof = M1(:, 4, :);

y_cof = M1(:, 3, :);
z_cof = M1(:, 5, :);
c_cof = M1(:, 6, :);

M2 = [y_cof, z_cof, c_cof];

for eq = 1:3
for var1 = 1:3
    y2_c = y2_cof(eq, 1, :);
    yz_c = yz_cof(eq, 1, :);
    z2_c = z2_cof(eq, 1, :);
    
    y2_v = y2(1, var1, :);
    yz_v = yz(1, var1, :);
    z2_v = z2(1, var1, :);
    
    y2_p = conv(y2_c(:), y2_v(:));
    yz_p = conv(yz_c(:), yz_v(:));
    z2_p = conv(z2_c(:), z2_v(:));
    
    M2(eq, var1, :) = M2(eq, var1, :) + reshape(y2_p((end-4):end) + yz_p((end-4):end) + z2_p((end-4):end), 1, 1, 5);
end
end

% DET
m11 = M2(1, 1, :);
m12 = M2(1, 2, :);
m13 = M2(1, 3, :);
m21 = M2(2, 1, :);
m22 = M2(2, 2, :);
m23 = M2(2, 3, :);
m31 = M2(3, 1, :);
m32 = M2(3, 2, :);
m33 = M2(3, 3, :);

D1 = conv(m11(:), conv(m22(:), m33(:)) - conv(m23(:), m32(:)));
D2 = conv(m12(:), conv(m21(:), m33(:)) - conv(m23(:), m31(:)));
D3 = conv(m13(:), conv(m21(:), m32(:)) - conv(m22(:), m31(:)));

D = D1 - D2 + D3;

X = roots(D((end-8):end));

X4 = [X.^4, X.^3, X.^2, X, ones(8, 1)];
YZ = zeros(8, 2);

for k = 1:8
    x = reshape(X4(k, :), 1, 1, 5);
    M3 = sum(M2.*x, 3);
    [~,~,V] = svd(M3);
    YZ(k, 1) = V(1, end) / V(3, end);
    YZ(k, 2) = V(2, end) / V(3, end);
end

XYZ = [X, YZ];
end
