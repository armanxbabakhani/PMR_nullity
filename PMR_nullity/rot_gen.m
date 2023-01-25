%% Reading in the initial data:

H_data = file_extract('heis6.txt');
U_data = file_extract('U4.txt');

%% Applying the unitary transformation:

[UHPs , UHZs, no_qubit] = Utransform(H_data , U_data);
    

%% Printing the output file after change of basis:

data_print(UHPs , UHZs , 'heis6_rotated.txt');