import numpy as np
import sys
import math


def baseconv(num , base):
	bigger = True; power = 0
	
	while bigger:
		if base**(power + 1) >= num:
			bigger = False
		else:
			power += 1
	
	array = np.zeros((1, power+1), dtype='int').flatten()
	if base**power == num:
		array[0] = 1
	else:
		for i in range(power+1):
			bpower = base**(power-i)
			term = int(math.floor(num/bpower))
			array[i] = term
			num -= term*bpower
	
	return array