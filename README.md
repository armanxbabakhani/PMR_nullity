# PMR_nullity

In this project, an output file of a Hamiltonian is generated from an input file of an unrotated Hamiltonian and that of a Unitary transformation.
The format of the input file is as follows

```math
\displaylines{c_{1} \quad n_{11} \, p_{11} \, n_{12} \, p_{12} \ldots n_{1k} \, p_{1k} \\\ c_{2} \quad n_{21} \, p_{21} \, n_{22} \, p_{22} \ldots n_{2k} \, p_{2k} \\\ \vdots \\\ c_m \quad n_{m1} \, p_{m1} \, n_{m2} \, p_{m2} \ldots n_{mk} \, p_{mk} } 
```
Here, $c_m$ represents a coefficient (float), $n_{mi}$ indicates the spin number (which spin), and `$p_{mi}$` represents the pauli matrix acting on the spin `$n_{mi}$`. `$p_{mi}$` could only take on integer values of `$\{0,1,2,3\}$`, where `$0$` is the identity matrix, `$1$` is the pauli X matrix, `$2$` is the pauli Y matrix, and `$3$` is the pauli Z matrix.
So, using this format of input and output for an input Hamiltonian and a Unitary transformation, we create another file of the same format.
