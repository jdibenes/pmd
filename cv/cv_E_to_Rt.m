
function [R_all, t_all] = cv_E_to_Rt(E)
[U,~,V] = svd(E);

if(det(U) < 0)
    U(:,3) = -U(:,3);
end

if (det(V) < 0)
    V(:,3) = -V(:,3);
end

D = [0  1   0;
     -1 0   0;
     0  0   1];

R_all = zeros(3, 3, 4);
t_all = zeros(3, 4);

for n = 1:4
    switch(n)
        case 1
            t = U(:,3);
            R = U*D*V';
        case 2
            t = -U(:,3);
            R = U*D*V';
        case 3
            t = U(:,3);
            R = U*D'*V';
        case 4
            t = -U(:,3);
            R = U*D'*V';
    end

    R_all(:, :, n) = R;
    t_all(:, n) = t;
end
end
