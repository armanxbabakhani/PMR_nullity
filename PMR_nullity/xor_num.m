function num = xor_num(num1 , num2)

arr1 = baseconv(num1 , 2);
arr2 = baseconv(num2 , 2);
l1 = length(arr1);
l2 = length(arr2);
if l1 > l2
    arr2 = [zeros(1, l1-l2) , arr2];
    l = l1;
elseif l2 > l1
    arr1 = [zeros(1, l2-l1) , arr1];
    l = l2;
else
    l = l2;
end

arr = xor(arr1, arr2);

num = 0;
for i= 1:length(arr)
    num = num + arr(l-i+1)*2^(i-1);
end

end