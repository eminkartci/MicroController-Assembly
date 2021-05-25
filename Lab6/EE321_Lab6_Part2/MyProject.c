
//PORTA Select which 7 seg will be written
//PORTB Assign value

// Assign all values rapidly so human cannot realize the difference

// Initialize the variables
int num1 = 0; 				// 10   ms
int num2 = 0; 				// 100  ms
int num3 = 0;				// 1000 ms
int state 	= 0; 			// start - stop
int buttonP = 0; 			// Control Button State - Perivous Comparison

void displayNum1(int);
void displayNum2(int);
void displayNum3(int);
void increment();
void reset();

void main(){

        // initialize the ports
		PCON.OSCF = 1;
		TRISA = 0xF0;
		TRISB = 0x00;
		PORTA = 0x00;
		PORTB = 0x00;

        while(1){
			// Give a delay as you want
			delay_ms(50);

			// This is a nice way to use button without using a delay function
			if( buttonP == 0 && RA5_bit == 1){
				state = (state == 9 ? 0 : state+1); // short if block
			}

			buttonP = RA5_bit; // Previous value

			// if reset button is pushed
			if (RA6_bit == 1 ){
					// call reset function
					reset();
			}


			if(state==1){
				increment();
			}

			// Use less component
			displayNum1(num1);
			delay_ms(3);
			displayNum2(num2);
			delay_ms(3);
			displayNum3(num3);
        }

}//SAME LAB5
void increment(){

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

}

// reset all numbers and assign them
void reset(){
	num1 = 0;
	num2 = 0;
	num3 = 0;
	state = 0;

}

void displayNum1(int num1) {
        PORTA = 0x06;//00000110
        PORTB = num1;
}


void displayNum2(int num2) {
        PORTA = 0x05;//00000101
        PORTB = num2;
}

void displayNum3(int num3) {
        PORTA = 0x03;//00000011
        PORTB = num3;
}




