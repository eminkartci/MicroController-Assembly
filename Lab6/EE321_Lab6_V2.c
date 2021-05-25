
//
/*

Author: Emin Kartcý S014877
Date  : 4 May 21
Github: eminkartci

--- CALCULATIONS ---

Clock 		: 1 MHZ (internal clock)
Prescale	: 4		(this is my personal choice - optional)
TMR1 		: 1		(use timer 1)
Per Cycle	: 4 micro sec

Per Step	: per cycle * prescale => 4 * 4 = 16 micro sec

Required Step For 1 Sec : 1 000 000 micro sec / Per Step => 1 000 000 / 16 = 62 500 steps
Hex of 62 500 			: 0xF424

Timer sends signal when it reaches 0xFFFF. Then I need to change its beginning to count 1 sec.

0xFFFF = 65 535
0xF424 = 62 500

65 535 - 62 500 = 3 035
3 035 = 0x0BDB

Initial State of Timer = 0xFFFF -  0xF424 = 0x0BDB

TMR1 in hex = 0x0BDB
	TMR1H = 0x0B
	TMR1L = 0xDB


*/


// Initialize the variables
int num1 = 0; 				// 10   ms
int num2 = 0; 				// 100  ms
int state = 0; 			// start - stop button controller
unsigned char buttonP = 0; 	// Control Button State - Perivous Comparison

// assign values to the ports
void assignValues(int left,int middle,int right);
// define combine numbers function
int combineNumbers(int num1,int num2);
// define reset function
void reset();
void increment();

// Define interrupt function
void interrupt();



void main(){

	// initialize the ports
	PCON.OSCF = 1;
	TRISA = 0xF0;
	TRISB = 0x00;
	PORTA = 0x00;
	PORTB = 0x00;

	// Timer Config

	//Scale 0 1 2 3 -> 1 2 4 8 respectively
	T1CON.T1CKPS0 = 0;
	T1CON.T1CKPS1 = 1;
	// my scale is 4 -> 10

	T1CON.TMR1CS = 0;	// Timer use internal clock

	TMR1L = 0xDB;	// Timer starts from counting
	TMR1H = 0X0B;	// Upper Limit of the count

	T1CON.TMR1ON = 1;	// Timer 1 is on



	// Interrupt Config

	// Enable global interrupt
	INTCON.GIE = 1;
	PIE1.TMR1IE = 1; // Turn on Timer 1's interrupt enable
	INTCON.PEIE = 1; // Turn on Peripheral interrupt enable

	while(1){

		/* Start Stop button controller
		if(RA5_bit == 1){
				// invert the variable
				if(state){
						state = 0;
						assignValues(state,num1,num2);
				}else{
						state = 1;
				}
		}
		*/

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


		assignValues(state,num1,num2);

	}

}

// reset all numbers and assign them
void reset(){

	state= 0;

}

void increment(){


			// increse the count
			num1++;
			// increase num2
			if(num1 == 10){
				num1 = 0;
				num2++;
				// increase num 3
				if (num2 == 10){
					num2 = 0;
				}
			}

}

int combineNumbers(int first4,int last4){
	return (first4<<4) + last4;
}

void assignValues(int left,int middle,int right){
	// Assign the values
		PORTA = right;				// I'm using only last 4 digits
		PORTB = combineNumbers(left,middle);	// combine num2 and num3
}


// During the interrupt
void interrupt(){
        increment();

        //todo reset timer1
        TMR1L = 0xDB;	// Timer starts from counting
        TMR1H = 0x0B;	// Upper Limit of the count
        //Timer one interupt flag reset
        PIR1.TMR1IF = 0;

}



