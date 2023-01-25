function [Plist,convlist] = porg(Ps) % to convert between the numeric list and the actual list, we need to take the numeric list and subtract by the convlist!
l = length(Ps);
Plist = zeros(1, l);
convlist = zeros(1, l);
for i=1:l
    num = find(Ps{i}(:,1)) - 1;
    Plist(i) = num;
    convlist(i) = num - i;
end
end

    