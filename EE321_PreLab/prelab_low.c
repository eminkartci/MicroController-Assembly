// This program does the same thing as prelab_hi.c
// It is the low-level C version of the same program
// In the low-level version, every line corresponds to an assembly instruction
max = a;
tmp = a;
tmp = tmp < b;
if(tmp == 0) goto END; // this is equivalent to a BranchOnZero (BZJ) instruction
  max = b;
END:
  goto END;
