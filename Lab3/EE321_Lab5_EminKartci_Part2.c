
// Initialize the variables
int num1 = 0; // 10   ms
int num2 = 0; // 100  ms
int num3 = 0; // 1000 ms = 1s
int num4 = 0; // 10    s
int num5 = 0; // 100   s
int isStart = 0; // start - stop button controller

// state 1 -> Most left digit indicates second, other two digits milliseconds between [9.99-0.00]
// state 2 -> Most left two digits indicate seconds, last digit millisecond between [99.9-10.0]
// state 3 -> All digits indicate seconds between [999-100]
int state = 1;

// define reset function
void reset();
void display();

// define combine numbers function
int combineNumbers(int num1,int num2);

// assign values to the ports
void assignValues(int left,int middle,int right);


void main(){

	// initialize the ports
	PCON.OSCF = 1;
	TRISA = 0xF0;
	TRISB = 0x00;
	PORTA = 0x00;
	PORTB = 0x00;

	// Infinite loop
	while(1){
		// count every 10 ms
		delay_ms(1);

		// if reset button is pushed
		if (RA6_bit == 1 ){
			// call reset function
			reset();
			delay_ms(10);
		}

		// Start Stop button controller
		if(RA5_bit == 1){
			// invert the variable
			if(isStart){
				isStart = 0;
			}else{
				isStart = 1;
			}
			delay_ms(10);
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
				num3 = 0;
				num4++;
				if(state == 1){
					state = 2;
				}
			}
			if(num4 == 10){
				num4 = 0;
				num5++;
				if(state == 2){
					state =3;
				}
			}
			if(num5 == 10){
				reset();
			}

			display();


		}

	}
}

void display(){

	if(state == 1){
		assignValues(num3,num2,num1);
	}if(state == 2){
		assignValues(num4,num3,num2);
	}if(state == 3){
		assignValues(num5,num4,num3);
	}

}

// reset all numbers and assign them
void reset(){
	num1 = 0;
	num2 = 0;
	num3 = 0;
	num4 = 0;
	num5 = 0;
	state = 1;
	display();

}

int combineNumbers(int first4,int last4){
	return (first4<<4) + last4;
}

void assignValues(int left,int middle,int right){
	// Assign the values
		TRISA = right;				// I'm using only last 4 digits
		PORTB = combineNumbers(left,middle);	// combine num2 and num3
}


