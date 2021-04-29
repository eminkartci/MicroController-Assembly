// This program does the same thing as lab_hi.c
// It is the low-level C version of the same program
// In the low-level version, every line corresponds to an assembly instruction
max = a;
tmp = a;
tmp = tmp < b;
if(tmp == 0) goto SKIP; // this is equivalent to a BranchOnZero (BZJ) instruction
	max = b;
SKIP:
    tmp = max;
	tmp = tmp < c;
	if(tmp == 0) goto END;
        max = c;
END:
	goto END;
