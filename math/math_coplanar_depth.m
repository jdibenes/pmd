
function st = math_coplanar_depth(h1, h2, h3, s1, s2, s3, ht)
st = -det([h1, h2, h3])*s1*s2*s3 / (det([h1, ht, h2])*s1*s2 + det([ht, h1, h3])*s1*s3 + det([h2, ht, h3])*s2*s3);
end

