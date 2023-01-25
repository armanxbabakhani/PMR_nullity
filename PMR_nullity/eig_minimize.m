function null_eigs_min = eig_minimize(null_eigs)
null_n = sum(null_eigs);
null_eigs_high = null_eigs(: , find(null_n > 3));
null_eigs_min = null_eigs(: , find(null_n == 3));
for i=1:size(null_eigs_high , 2)
    for j=1:size(null_eigs_min , 2)
        null_i = xor(null_eigs_high(:,i)' , null_eigs_min(:,j)');
        if sum(null_i) == 3
            null_eigs_high(:,i) = null_i';
            break;
        end
    end
end
null_eigs_min = [null_eigs_min , null_eigs_high];

end