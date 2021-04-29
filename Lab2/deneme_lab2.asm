0: CP 50 90                    // *50 = k   WHILE1
1: LT 50 100                   // if(k < SIZE)
2: BZJ 80 50                   // PC++  (continue to loop or break)
3: CPi 91 0                    // m = 0
4: CP 40 90                    // *40 = k   WHILE2 
5: NAND 40 40                  // -k-1
6: ADD 40 100                  // SIZE-k-1
7: CP 60 91                    // *40 = m
8: LT 60 40                    // if(m < SIZE-k-1)
9: BZJ 81 60                   // PC++ (continue to loop or break)
10: CP 93 85
11: ADD 93 91
12: CPI 94 93
13: CP 95 93
14: ADDi 95 1
15: CPI 96 95
16: LT 96 94
17: BZJ 83 96
18: CPI 97 93
19: CPI 98 95
20: CPIi 93 98
21: CPIi 95 97
22: BZJi 83 0

55: ADDi 91 1
56: BZJi 82 4  // goto WHILE2

70: ADDi 90 1  // END_WHILE2 + INC_k
71: BZJi 82 0  // goto WHILE1


80: 2
81: 70
82: 0
83: 55

93: 0
94: 0
95: 0
96: 0
97: 0
98: 0

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