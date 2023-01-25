function array = baseconv(num , base)
bigger = 1;
power = 0;
while bigger
    if base^(power+1)-1 >= num
        bigger = 0;
    else
        power = power + 1;
    end
end

array = zeros(1,power+1);
if base^power == num
    array(1) = 1;
else
    for i = 1:power+1
        bpower = base^(power+1-i);
        term = floor(num/(bpower));
        array(i) = term;
        num = num - term*bpower;
    end
end
end