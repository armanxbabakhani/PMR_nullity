function data = file_extract(infile)
dataf = fopen(infile);

tline = fgetl(dataf);
i=1;
while ischar(tline)
    tlinearray = str2num(tline);
    data{i} = {tlinearray(1) , real(tlinearray(2:end))};
    tline = fgetl(dataf);
    i = i + 1;
end

fclose(dataf);
end