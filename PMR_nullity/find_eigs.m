function [null_eigs , k] = find_eigs(Ps , no_qubit)

no_of_ps = length(Ps);
plist_bin = zeros(no_of_ps,no_qubit); %initializing binary vector

for i = 1:no_of_ps
    array = baseconv(Ps(i) , 2);
    p = length(array);
    plist_bin(i,end-p+1:end) = array; % plist in binary form!
end
null_eigs = null2(plist_bin');
k = size(null_eigs,2);
end