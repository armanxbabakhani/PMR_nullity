# This code generates generates a script of interactions input file by taking in an 
# original input file and another input file specifying the unitary transformation.

import numpy as np
import sys
from functions import *

def extract_file(file):
	infile = open(file, 'r')
	lines = infile.readlines()

	# constructing the unitary file
	data = [];
	for l in lines:
		line_l = l.split()
		data_c = complex(line_l[0])
		data_l = [int(x) for x in line_l[1::]]
		data_l.insert(0, data_c)
		data.append(data_l)

	infile.close()
	return data

def extract_Ps(data):
	l = len(data);
	coefficients_0 = np.zeros((l,1), dtype='complex')
	Ps = np.array([], dtype = 'int');
	coeffs = np.array([], dtype = 'complex');
	Zs = []
	#Zs = np.array([]);

	no_qubit = 0
	for i in range(l):
		coefficients_0[i] = data[i][0]
		data_i =  data[i][1::]
		num = 0
		zs = []
		for j in range(int(len(data_i)/2)):
			pauli_j = data_i[2*j+1]
			qubit = data_i[2*j]
			if qubit > no_qubit:
				no_qubit = qubit

			if pauli_j == 1:
				num = num + int(2**(qubit-1))
			elif pauli_j == 2:
				num = num + int(2**(qubit-1))
				coefficients_0[i] = 1.0j*coefficients_0[i]
				zs.append(qubit)
			elif pauli_j == 3:
				zs.append(qubit)
		common = np.argwhere(Ps == num)
		if len(common) == 0:
			Ps = np.append(Ps , num)
			coeffs = np.append(coeffs , coefficients_0[i])
			Zs.append([[coefficients_0[i]] , [zs]])
		else:
			common = common[0][0]
			print('common is: ' , common)
			print('Zs[common][1]: ' , Zs[common][1])
			if Zs[common][1]!= zs:
				Zs[common][0].append(coefficients_0[i])
				Zs[common][1].append(zs)
			else:
				coeffs[common] += coefficients_0[i]
	
	# Removing elements with zero coefficient!
	for i in range(len(coeffs)):
		if abs(coeffs[i]) < 1E-7:
			Ps = np.delete(Ps, i)
			del Zs[i]
			
	# Sorting the arrays based on increasing P index number!
	indices = np.argsort(Ps)
	Ps = Ps[indices]
	Zs_sorted = Zs.copy()
	for i in range(len(indices)):
		Zs_sorted[i] = Zs[indices[i]]
	return Ps , Zs_sorted
	
# Reading in the Hamiltonian file:
Ham_file = sys.argv[1]

Ham_0_data = extract_file(Ham_file)


print('Hamiltonian data extraction completed!')

# Reading in the unitary file:
U_file = sys.argv[2]

U_data = extract_file(U_file)

print('Unitary data extraction completed!')
# Extracting the permutations and indices from the Hamiltonian

Ham_0_Ps , Ham_0_zs = extract_Ps(Ham_0_data)
		
# Extracting the permutations and indices from the Hamiltonian

U_Ps , U_zs = extract_Ps(U_data)

print('Ham Ps are: ', Ham_0_Ps)
print('Ham Zs are: ', Ham_0_zs)


# In order to compute UHU^dagger, only thing we need is to multiply the coefficients from U
# by the corresponding coefficients from U^dagger. Another thing is to keep track of minus sign if there are common Z
# from U and X from H. To pass the Z of U from X of H, we will need an additional minus sign if Z and X are acting on 
# the same qubit!
		

		
		
