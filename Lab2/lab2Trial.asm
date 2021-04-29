0: CP 50 90                    // *50 = k   WHILE1
1: LT 50 100                   // if(k < SIZE)
2: BZJ 80 50                   // PC++  (continue to loop or break)
3: CPi 91 0                    // m = 0
4: CP 40 90                    // *40 = k   WHILE2
5: NAND 40 40                  // -k-1  						HELP
6: ADD 40 100                  // SIZE-k-1
7: CP 60 91                    // *60 = m 						HELP
8: LT 60 40                    // if(m < SIZE-k-1)
9: BZJ 81 60                   // PC++ (continue to loop or break)
10: CP 150 85	// temp <- a (start address of array)
11: ADD 150 91 	// temp <- a+m
12: CPI 151 150// temp2 <- *(a+m)
13: CP 152 150// temp3 <- a+m
14: ADDi 152 1// temp3 <- a+m+1
15: CPI 153 152// temp4 <- *(a+m+1)
16: LT 153 151// temp4 <- (*(a+m+1) < *(a+m))
17: BZJ 83 153// if (temp4 == 0 ) goto INC_m
18: CPI 97 150// temp5 <- *(a+m)
19: CPI 98 152// temp6 <- *(a+m+1)
20: CPIi 150 98// *(a+m) <- temp6
21: CPIi 152 97// *(a+m+1) <- temp5
22: BJZi 83 0// jump to 55

55: ADDi 91 1  // INC_m
56: BZJi 82 4  // goto WHILE2

70: ADDi 90 1  // END_WHILE2 + INC_k
71: BZJi 82 0  // goto WHILE1


80: 2
81: 70
82: 0
83: 55
97: 0          // temp5
98: 0          // temp6

85: 101  // a (start address of array)

90: 0   // k
91: 0   // m  (current array index)

100: 10  // SIZE
101: 9   // first element of array
102: 1
103: 2
104: 4
105: 3
106: 7
107: 5
108: 0
109: 8
110: 6   // last element of array


130: BZJi 131 0   // END_WHILE1, also end of program
131: 130

