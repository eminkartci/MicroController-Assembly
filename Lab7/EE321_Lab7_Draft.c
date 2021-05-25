
/*

Author : Emin Kartci
Date   : 4 May 21
GitHub : eminkartci
Website: eminkartci.com


PWM Calculations

 -- Solve PWM Period Formula for PR2 --

				--- 3KHz --
	PWM Period : (3000)^-1
	Prescale   : 16
	TOSC       : (20000000)^-1

	PPR2       =((1/3000)/(1/20000000*4*16))– 1
	PR2	   	   =103.166666667 -> as integer: 103

	%25
	    (1/3000*0.25)/(1/20000000*16) = 104.16 -> as integer: 104 -> as binary: 0001101000
	    CCPR1L:CCP1CON<5:4>	= 0b0001101000
	%50
        (1/3000*0.5)/(1/20000000*16)  = 208.33 -> as integer: 208 -> as binary: 0011010000
	    CCPR1L:CCP1CON<5:4>	= 0b0011010000
	%75
	    (1/3000*0.75)/(1/20000000*16) = 312.5  -> as integer: 312 -> as binary: 0100111000
	    CCPR1L:CCP1CON<5:4>	= 0b0100111000

				--- 15KHz --
	PR2 value	for	prescaler	value	of	16;
	PR2	=(1/15000)/(1/20000000*4*16))– 1
	PR2	=19.8333333333 -> as integer: 20

	%25
	    (1/15000*0.25)/(1/20000000*16) = 20.83 -> as integer: 20 -> as binary: 0000010101 
        CCPR1L:CCP1CON<5:4>	= 0b0000010101?
	%50
	    (1/15000*0.5)/(1/20000000*16)  = 41.66 -> as integer: 41 -> as binary: 0000101010
	    CCPR1L:CCP1CON<5:4>	= 0b0000101010
	%75
	    (1/15000*0.75)/(1/20000000*16) = 62.5  -> as integer: 62 -> as binary: 0000111111
	    CCPR1L:CCP1CON<5:4>	= 0b0000111111

*/

int periodState = 0; // 15KHz - 3KHz
int dutyState   = 0; // %25   - %50 - %75

void main(){

	
	TRISA		=0x00;
	PORTB		=0x00;
	//set pwm period for 15 KhZ as default
	PR2 		= 20;
	//set pwm duty cycle
	CCPR1L 		 = 0b00000101;
	CCP1CON 	|= 0b00010000;
	//set 3rd bit of port b as an output
	TRISB.F3	=0;
	//SET TMR2 PRESCALE VALUE : 4
	T2CON.F0	=1;
	T2CON.F1	=1;
	T2CON.F2	=1;//Timer on
	//Configure CCP1 module for PWM Op
	CCP1CON.CCP1M3=1;
	CCP1CON.CCP1M2=1;

	//INTERRUPT OP.
	INTCON.GIE 	= 1;
	INTCON.RBIE = 1;
	INTCON.RBIF = 0;
	//motor right
	RA0_bit = 0;
	RA1_bit = 1;



}

// Interrupt Method
void interrupt(){


	//REVERSE DIRECTION BUTTON
	if(RB4_bit==1){
		// Change Direction
		if(RA0_bit == 1){ // Right
			RA0_bit = 0;
			RA1_bit = 1;
		}
		else{// Left
			RA0_bit = 1;
			RA1_bit = 0;
		}
	}

	// CHANGE PERIOD BUTTON
	if(RB5_bit==1){
		
		// State 0 is 15 khz
		// State 1 is  3 kHz
		
		// If previous value is 0
		if(periodState==0){
			
			// Make it 1
			periodState=1;
			
			// Set PR2
			PR2 = 103;
			
			// DUTY CYCLE
			if(dutyState==0){
				// 25%
				CCPR1L   = 0b00011001;
				CCP1CON |= 0b00000000;
			}
			else if (dutyState==1){
				// 50%
				CCPR1L   = 0b00110010;
				CCP1CON |= 0b00000000;
			}
			else if (dutyState==2){
				// 75&
				CCPR1L   = 0b01001011;
				CCP1CON |= 0b00000000;
			}
		}
		else if(periodState==1){
			
			// Change Period state
			periodState=0;
			// Set Period
			PR2 = 20;
			// DUTY CYCLE
			if(dutyState==0){
				// 25%
				CCPR1L   = 0b00011001;
				CCP1CON |= 0b00000000;
			}
			else if (dutyState==1){
				// 50%
				CCPR1L   = 0b00110010;
				CCP1CON |= 0b00000000;
			}
			else if (dutyState==2){
				// 75&
				CCPR1L   = 0b01001011;
				CCP1CON |= 0b00000000;
			}
		}
	}

	//CHANGE DUTY CYCLE
	if(RB6_bit==1){
		dutyState++;
		if(dutyState>2)
			dutyState=0;
	}
	if(periodState==0){
		if(dutyState==0){//%25 to do
			CCPR1L = 0b00000101;
			CCP1CON |= 0b00010000;
		}
		else if (dutyState==1){//%50 to do
			CCPR1L = 0b00001010;
			CCP1CON |= 0b00100000;
		}
		else if (dutyState==2){//%75 to do
			CCPR1L = 0b00001111;
			CCP1CON |= 0b00110000;
		}
	}
	else if(periodState==1){
		if(dutyState==0){//%25 to do
			CCPR1L = 0b00011010;
			CCP1CON |= 0b00000000;
		}
		else if (dutyState==1){//%50 to do
			CCPR1L = 0b00110100;
			CCP1CON |= 0b00000000;
		}
		else if (dutyState==2){//%75 to do

			CCPR1L = 0b01001110;
			CCP1CON |= 0b00000000;
		}
	}
	//CCP1CON.CCP1M3=1;
	//CCP1CON.CCP1M2=1;
	INTCON.RBIF = 0;
}