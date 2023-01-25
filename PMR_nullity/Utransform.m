function [UHPs , UHZs, no_qubit] = Utransform(H_data , U_data)

[HPs , HZs , no_qubit] = PZcomp(H_data);
[UPs , UZs , no_qubit] = PZcomp(U_data);

% Make binary z and x vectors
[Hbz , Hcs] = binaryz(HZs);
[Ubz , Ucs] = binaryz(UZs);
lu = length(UPs);
lh = length(HPs);

% Applying the unitary transformation
UHPs = [];
z_count = 1;
for i=1:lu
    for m=1:lh
        for ip=1:lu
            new_p = xor_num(UPs(i) , xor_num(HPs(m) , UPs(ip)));
            common_p = find(UHPs == new_p);
            num_count = 1;
            for j = 1:length(Ubz{i})
                for n = 1:length(Hbz{m})
                    for jp = 1:length(Ubz{ip})
                        c = (Ucs{ip}{jp})'*Ucs{i}{j}*Hcs{m}{n};
                        sign = (-1)^(sum(and_arr(Ubz{ip}{jp}, baseconv(UPs(ip),2))) + sum(and_arr(Hbz{m}{n}, baseconv(UPs(ip),2))) + sum(and_arr(Ubz{i}{j}, baseconv(UPs(ip),2))) + sum(and_arr(Ubz{i}{j}, baseconv(HPs(m),2))));
                        c = sign*c;
                        uhbz = xor_arr(Ubz{i}{j}, xor_arr(Hbz{m}{n} , Ubz{ip}{jp}));
                        uhzs = find(flip(uhbz));
                        if isempty(common_p) && num_count == 1
                            UHPs = [UHPs ; new_p];
                            UHZs{z_count} = {{c} , {uhzs}};
                            z_count = z_count + 1;
                            num_count = num_count + 1;
                        else
                            if isempty(common_p)
                                common_p = size(UHPs,1);
                            end
                            lhz = length(UHZs{common_p}{2});
                            common_l = 0;
                            for l=1:lhz
                                if isequal(UHZs{common_p}{2}{l} , uhzs)
                                    common_l = l;
                                    break;
                                end
                            end
                            if common_l == 0
                                UHZs{common_p}{1} = {UHZs{common_p}{1}{:} , c};
                                UHZs{common_p}{2} = {UHZs{common_p}{2}{:} , uhzs};
                            else
                                UHZs{common_p}{1}{common_l} = UHZs{common_p}{1}{common_l} + c;
                            end
                        end
                    end
                end
            end
        end
    end
end

ind_keep = 1:length(UHZs);
for i=1:length(UHZs)
    liz = length(UHZs{i}{2});
    ind_keep_i = 1:liz;
    for j=1:liz
        if abs(UHZs{i}{1}{j}) < 1E-7
            ind = find(ind_keep_i == j);
            ind_keep_i = [ind_keep_i(1:ind-1) , ind_keep_i(ind+1:end)];
        end
    end
    if isempty(ind_keep_i)
        ind = find(ind_keep == i);
        ind_keep = [ind_keep(1:ind-1), ind_keep(ind+1:end)];
    else
        UHZs{i}{1} = UHZs{i}{1}(ind_keep_i);
        UHZs{i}{2} = UHZs{i}{2}(ind_keep_i);
    end
end

UHZs = UHZs(ind_keep);
UHPs = UHPs(ind_keep);

[UHPs , indices] = sort(UHPs);
UHZs = UHZs(indices);
end