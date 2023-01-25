function data_print(Ps , Zs , out_name)

fileID = fopen(out_name , 'w');
for i = 1:length(Ps)
    bin_x = baseconv(Ps(i) , 2);
    x_indices = find(flip(bin_x));
    lx = length(x_indices);
    for j = 1:length(Zs{i}{1})
        format_string = '\n';
        z_indices = sort(Zs{i}{2}{j});
        [y_indices , xcom , zcom] = intersect(x_indices , z_indices);
        ly = length(y_indices);
        pure_x = sort(setdiff(x_indices , y_indices));
        pure_z = sort(setdiff(z_indices , y_indices));
        tot_len = lx + length(z_indices) - ly;
        coeff = (-1.0i)^ly * Zs{i}{1}{j};
        num_string = [];
        for l = 1:tot_len
            format_string = ['%4i %4i' , format_string];
        end
        
        for l = 1:length(pure_x)
            num_string = [num_string , [pure_x(l) 1]];
        end
        for l = 1:length(y_indices)
            num_string = [num_string , [y_indices(l) 2]];
        end
        for l = 1:length(pure_z)
            num_string = [num_string , [pure_z(l) 3]];
        end
        num_string = [coeff , num_string];
        format_string = ['%6f ', format_string];
        fprintf(fileID , format_string , num_string); 
    end
end

fclose(fileID);

end