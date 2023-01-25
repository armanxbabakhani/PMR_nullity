function [Ps , Zs , no_qubit] = PZcomp(data)

% The input data will be of the form:
% data{i} = [c(i) n1(i) Pauli1(i) n2(i) Pauli2(i) ... nk(i) Paulik(i)];
l = length(data);
coefficients = zeros(l,1);
Ps = [];
coeffs = [];
z_count = 1;
no_qubit = 0;
for i=1:l
    coefficients(i) = data{i}{1};
    data_i = data{i}{2};
    % Note that the length of data_i is even since the input requires the
    % index of the qubit and the appropriate pauli for that qubit. So,
    % there are 2*n input variables (ignoring the coefficient) for n
    % qubits!
    num = 0;
    zs = [];
    for j = 1:length(data_i)/2
        pauli_j = data_i(2*j);
        qubit = data_i(2*j-1);
        if qubit > no_qubit
			no_qubit = qubit;
        end
        if pauli_j == 1 % In case of Pauli X!
            num = num + 2^(qubit-1);
        elseif pauli_j == 2 % In case of Pauli Y!
            num = num + 2^(qubit-1);
            coefficients(i) = 1i*coefficients(i);
            zs = [zs, qubit];
        elseif pauli_j == 3
            zs = [zs, qubit];
        end
    end
    %zs = [num , zs];
    common_p = find(Ps == num);
    if isempty(common_p)
        Ps = [Ps ; num];
        coeffs = [coeffs ; coefficients(i)];
        Zs{z_count} = {{coefficients(i)} , {zs}};
        z_count = z_count+1;
    else
        % Contains a mistake! instance of equal z must be found and their
        % corresponding coefficients must be added!
        lhz = length(Zs{common_p}{2});
        common_l = 0;
        for l=1:lhz
            if isequal(Zs{common_p}{2}{l} , zs)
                common_l = l;
                break;
            end
        end
        if common_l == 0
            Zs{common_p}{1} = {Zs{common_p}{1}{:} , coefficients(i)};
            Zs{common_p}{2} = {Zs{common_p}{2}{:} , zs};
        else
            Zs{common_p}{1}{common_l} = Zs{common_p}{1}{common_l} + coefficients(i);
        end
%         if ~isequal(Zs{common}{2} , zs)
%             Zs{common}{1} = {Zs{common}{1}{:} , coefficients(i)};
%             Zs{common}{2} = {Zs{common}{2}{:} , zs};
%         else
%             coeffs(common) = coeffs(common) + coefficients(i);
%         end
    end
end

% Removing any zero coefficient terms:
ind_keep = 1:length(coeffs);
for i=1:length(coeffs)
    if abs(coeffs(i)) < 1E-7
        ind = find(ind_keep == i);
        ind_keep = [ind_keep(1:ind-1) , ind_keep(ind+1:end)];
    end
end

Ps = Ps(ind_keep);
Zs = Zs(ind_keep);

[Ps , indices] = sort(Ps);
Zs = Zs(indices);
end