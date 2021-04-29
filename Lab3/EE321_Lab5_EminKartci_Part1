
// Initialize the variables
int num1 = 0; // 100 ms
int num2 = 0; // 1000 ms
int num3 = 0; // 10 s
int isStart = 0; // start - stop button controller

// define reset function
void reset();

// define combine numbers function
int combineNumbers(int num1,int num2);

// assign values to the ports
void assignValues();


void main(){

	// initialize the ports
	PCON.OSCF = 1;
	TRISA = 0xF0;
	TRISB = 0x00;
	PORTA = 0x00;
	PORTB = 0x00;
	
	// Infinite loop
	while(1){
		// count every 100 ms
		delay_ms(100);

		// if reset button is pushed
		if (RA6_bit == 1 ){
			// call reset function
			reset();
		}

		// Start Stop button controller
		if(RA5_bit == 1){
			// invert the variable
			if(isStart){
				isStart = 0;
			}else{
				isStart = 1;
			}
		}

		// if program clock is running
		if (isStart){
			
			// increse the count
			num1++;
			
			// increase num2
			if(num1 == 10){
				num1 = 0;
				num2++;
			}// increase num 3
			if (num2 == 10){
				num2 = 0;
				num3++;
			} // reset clock
			if(num3 == 10){
				reset();
			}
			
			assignValues();

			
		}

	}
}

// reset all numbers and assign them
void reset(){
	num1 = 0;
	num2 = 0;
	num3 = 0;
	assignValues();
	
}

int combineNumbers(int first4,int last4){
	return (first4<<4) + last4;
}

void assignValues(){
	// Assign the values
		TRISA = num1;				// I'm using only last 4 digits
		PORTB = combineNumbers(num3,num2);	// combine num2 and num3
}


