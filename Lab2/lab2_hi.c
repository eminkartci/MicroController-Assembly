/******** High-level C code of bubble sort (ascending order) ********/

void main() {
	
	int SIZE = 10;
	int a[SIZE] = {9, 1, 2, 4, 3, 8, 7, 6, 5, 0}; 
	int k = 0, m  = 0, temp; 

	while (k < SIZE) {
		m = 0;
		while(m < SIZE-k-1) {
			if (a[m] > a[m+1]){
			   temp   = a[m];
		       a[m]   = a[m+1];
		       a[m+1] = temp;
			}
			m++;
		}
		k++;
	}
}
