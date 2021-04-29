//Assume that the number at *100 is maximum number
0: CP 110 100
// To compare the numbers initialize *50
1: CP 50 100
// Check if first number is less than 101
2: LT 50 101
// if Location 50 is false jump tp *20 -> 5 line
3: BZJ 20 50
// otherwise set max number as *101
4: CP 110 101
// To check *102 and *110 initialize *51
5: CP 51 110
// Check if *51 less than *102
6: LT 51 102 
// If *51 contains 0 jump to *21 -> 9
7: BZJ 21 51
// otherwise assign *110 to *102
8: CP 110 102
// then jump to *21 -> 9 (infinite loops)
9: BZJi 21 0

// MEMORY
20: 5
21: 9
100: 41
101: 39
102: 43