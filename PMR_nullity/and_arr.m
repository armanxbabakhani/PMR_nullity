function arr = and_arr(b1 , b2)
l1 = length(b1);
l2 = length(b2);

if l1 > l2
    arr = (b1 & [zeros(1,l1-l2) , b2]);
else
    arr = ([zeros(1,l2-l1) , b1] & b2);
end
end