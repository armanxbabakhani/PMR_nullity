import numpy as np
import sys
import math
from functions import *

# Reading in the file:
input_file = sys.argv[1]

infile = open(input_file, 'r')
lines = infile.readlines()


# constructing the data file
data = [];
for l in lines:
	line_l = l.split()
	data_c = complex(line_l[0])
	data_l = [int(x) for x in line_l[1::]]
	data_l.insert(0, data_c)
	data.append(data_l)

infile.close()


l = len(data);
coefficients = np.zeros((l,1), dtype='complex')
Ps = np.array([]);

no_qubit = 0
for i in range(l):
	coefficients[i] = data[i][0]
	data_i =  data[i][1::]
	num = 0
	for j in range(int(len(data_i)/2)):
		pauli_j = data_i[2*j+1]
		qubit = data_i[2*j]
		if qubit > no_qubit:
			no_qubit = qubit

		if pauli_j == 1:
			num = num + int(2**(qubit-1))
		elif pauli_j == 2:
			num = num + int(2**(qubit-1))
			coefficients[i] = 1.0j*coefficients[i]
	if num > 0 and ~np.any(Ps == num):
		Ps = np.append(Ps, num)

print('The permutation indices are: ' + str(Ps))
		
		
# Now computing the the mod2 null space:

no_of_ps = Ps.shape[0]
plist_bin = np.zeros((no_of_ps , no_qubit))

for i in range(no_of_ps):
	array = baseconv(Ps[i] , 2)
	p = len(a)
	plist_bin(i, no_qubit-p::) = array

null_eigs = null2(np.transpose(plits_bin))
k = null_eigs.shape[1]





