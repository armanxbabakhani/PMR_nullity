function [binary_z , coeffs] = binaryz(Zs)
for i=1:length(Zs)
    for j=1:length(Zs{i}{2})
        z_array = zeros(1, max(Zs{i}{2}{j}));
        z_array(Zs{i}{2}{j}) = 1;
        binary_z{i}{j} = flip(z_array);
        coeffs{i}{j} = Zs{i}{1}{j};
    end
end

end