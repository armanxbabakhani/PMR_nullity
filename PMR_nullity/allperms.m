function [Ps , DPs] = allperms(H)
dim = length(H);
cyclist = cycperms(dim);
count = 1;
for i=1:size(cyclist,1)
    dps = zeros(dim);
    ps = zeros(dim);
    for j=1:int32(size(cyclist,2)/2)
        dps(cyclist(i,2*j-1) , cyclist(i,2*j)) = H(cyclist(i,2*j-1) , cyclist(i,2*j));
        ps(cyclist(i,2*j-1) , cyclist(i,2*j)) = 1;
    end
    if ~all(all(abs(dps) < 1E-7))
        Ps{count} = ps + ps';
        DPs{count} = dps + dps';
        count = count + 1;
    end
end
end
    
    