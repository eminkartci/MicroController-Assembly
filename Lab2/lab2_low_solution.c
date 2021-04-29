/******** Low-level C code of bubble sort (ascending order)  ********/

void main() {
	
	int SIZE = 10;
	int a[SIZE] = {9, 1, 2, 4, 3, 8, 7, 6, 5, 0}; 
	int k = 0, m  = 0, temp; 

	WHILE1:
	   if (!(k < SIZE))
		   goto END_WHILE1;       
	   m = 0;
	   WHILE2:
		  if (!(m < SIZE-k-1))	
			  goto END_WHILE2;
		  
		  if (*(a+m) < *(a+m+1))
			 goto INC_m;
		  temp = *(a+m);
		  *(a+m) = *(a+m+1);
		  *(a+m+1) = temp;
   
		  INC_m: m++;
		  goto WHILE2;
	   
	   END_WHILE2:   
			   
	   INC_k: k++;
	   goto WHILE1;
	END_WHILE1:
}
