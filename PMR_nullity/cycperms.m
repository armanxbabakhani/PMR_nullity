function y = cycperms(dim)
list = 2:dim;
for i=2:dim
    currlist = [1:i-1 i+1:dim];
    list = [list ; currlist];
end

y = [];
while ~isempty(list)
    unpaired = 1:dim;
    pairedlist = [];
    currlist = zeros(dim, size(list,2)-1);
    while length(unpaired) > 1
        currno = unpaired(1);
        unpaired = unpaired(2:end);
        availunpred = intersect(unpaired, list(currno,:)); % finding the available unpaired number to pair with!
        pairing = availunpred(1);
        pairedlist = [pairedlist [currno pairing]];
        unpaired = unpaired(find(unpaired~=pairing));
        % remove the numbers from the list
        ind1 = find(list(pairing,:) ~= currno);
        ind2 = find(list(currno,:) ~= pairing);
        currlist(pairing,:) = list(pairing, ind1);
        currlist(currno, :) = list(currno, ind2);
    end
    list = currlist;
    y = [y; pairedlist];
end
end