
_main:

;EE321_Lab6_V2.c,58 :: 		void main(){
;EE321_Lab6_V2.c,61 :: 		PCON.OSCF = 1;
	BSF        PCON+0, 3
;EE321_Lab6_V2.c,62 :: 		TRISA = 0xF0;
	MOVLW      240
	MOVWF      TRISA+0
;EE321_Lab6_V2.c,63 :: 		TRISB = 0x00;
	CLRF       TRISB+0
;EE321_Lab6_V2.c,64 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;EE321_Lab6_V2.c,65 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;EE321_Lab6_V2.c,70 :: 		T1CON.T1CKPS0 = 0;
	BCF        T1CON+0, 4
;EE321_Lab6_V2.c,71 :: 		T1CON.T1CKPS1 = 1;
	BSF        T1CON+0, 5
;EE321_Lab6_V2.c,74 :: 		T1CON.TMR1CS = 0;	// Timer use internal clock
	BCF        T1CON+0, 1
;EE321_Lab6_V2.c,76 :: 		TMR1L = 0xDB;	// Timer starts from counting
	MOVLW      219
	MOVWF      TMR1L+0
;EE321_Lab6_V2.c,77 :: 		TMR1H = 0X0B;	// Upper Limit of the count
	MOVLW      11
	MOVWF      TMR1H+0
;EE321_Lab6_V2.c,79 :: 		T1CON.TMR1ON = 1;	// Timer 1 is on
	BSF        T1CON+0, 0
;EE321_Lab6_V2.c,86 :: 		INTCON.GIE = 1;
	BSF        INTCON+0, 7
;EE321_Lab6_V2.c,87 :: 		PIE1.TMR1IE = 1; // Turn on Timer 1's interrupt enable
	BSF        PIE1+0, 0
;EE321_Lab6_V2.c,88 :: 		INTCON.PEIE = 1; // Turn on Peripheral interrupt enable
	BSF        INTCON+0, 6
;EE321_Lab6_V2.c,90 :: 		while(1){
L_main0:
;EE321_Lab6_V2.c,105 :: 		if( buttonP == 0 && RA5_bit == 1){
	MOVF       _buttonP+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main4
	BTFSS      RA5_bit+0, BitPos(RA5_bit+0)
	GOTO       L_main4
L__main10:
;EE321_Lab6_V2.c,106 :: 		state = (state == 9 ? 0 : state+1); // short if block
	MOVLW      0
	XORWF      _state+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main12
	MOVLW      9
	XORWF      _state+0, 0
L__main12:
	BTFSS      STATUS+0, 2
	GOTO       L_main5
	CLRF       ?FLOC___mainT20+0
	CLRF       ?FLOC___mainT20+1
	GOTO       L_main6
L_main5:
	MOVF       _state+0, 0
	ADDLW      1
	MOVWF      ?FLOC___mainT20+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _state+1, 0
	MOVWF      ?FLOC___mainT20+1
L_main6:
	MOVF       ?FLOC___mainT20+0, 0
	MOVWF      _state+0
	MOVF       ?FLOC___mainT20+1, 0
	MOVWF      _state+1
;EE321_Lab6_V2.c,107 :: 		}
L_main4:
;EE321_Lab6_V2.c,109 :: 		buttonP = RA5_bit; // Previous value
	MOVLW      0
	BTFSC      RA5_bit+0, BitPos(RA5_bit+0)
	MOVLW      1
	MOVWF      _buttonP+0
;EE321_Lab6_V2.c,112 :: 		if (RA6_bit == 1 ){
	BTFSS      RA6_bit+0, BitPos(RA6_bit+0)
	GOTO       L_main7
;EE321_Lab6_V2.c,114 :: 		reset();
	CALL       _reset+0
;EE321_Lab6_V2.c,115 :: 		}
L_main7:
;EE321_Lab6_V2.c,118 :: 		assignValues(state,num1,num2);
	MOVF       _state+0, 0
	MOVWF      FARG_assignValues_left+0
	MOVF       _state+1, 0
	MOVWF      FARG_assignValues_left+1
	MOVF       _num1+0, 0
	MOVWF      FARG_assignValues_middle+0
	MOVF       _num1+1, 0
	MOVWF      FARG_assignValues_middle+1
	MOVF       _num2+0, 0
	MOVWF      FARG_assignValues_right+0
	MOVF       _num2+1, 0
	MOVWF      FARG_assignValues_right+1
	CALL       _assignValues+0
;EE321_Lab6_V2.c,120 :: 		}
	GOTO       L_main0
;EE321_Lab6_V2.c,122 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_reset:

;EE321_Lab6_V2.c,125 :: 		void reset(){
;EE321_Lab6_V2.c,127 :: 		state= 0;
	CLRF       _state+0
	CLRF       _state+1
;EE321_Lab6_V2.c,129 :: 		}
L_end_reset:
	RETURN
; end of _reset

_increment:

;EE321_Lab6_V2.c,131 :: 		void increment(){
;EE321_Lab6_V2.c,135 :: 		num1++;
	INCF       _num1+0, 1
	BTFSC      STATUS+0, 2
	INCF       _num1+1, 1
;EE321_Lab6_V2.c,137 :: 		if(num1 == 10){
	MOVLW      0
	XORWF      _num1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__increment15
	MOVLW      10
	XORWF      _num1+0, 0
L__increment15:
	BTFSS      STATUS+0, 2
	GOTO       L_increment8
;EE321_Lab6_V2.c,138 :: 		num1 = 0;
	CLRF       _num1+0
	CLRF       _num1+1
;EE321_Lab6_V2.c,139 :: 		num2++;
	INCF       _num2+0, 1
	BTFSC      STATUS+0, 2
	INCF       _num2+1, 1
;EE321_Lab6_V2.c,141 :: 		if (num2 == 10){
	MOVLW      0
	XORWF      _num2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__increment16
	MOVLW      10
	XORWF      _num2+0, 0
L__increment16:
	BTFSS      STATUS+0, 2
	GOTO       L_increment9
;EE321_Lab6_V2.c,142 :: 		num2 = 0;
	CLRF       _num2+0
	CLRF       _num2+1
;EE321_Lab6_V2.c,143 :: 		}
L_increment9:
;EE321_Lab6_V2.c,144 :: 		}
L_increment8:
;EE321_Lab6_V2.c,146 :: 		}
L_end_increment:
	RETURN
; end of _increment

_combineNumbers:

;EE321_Lab6_V2.c,148 :: 		int combineNumbers(int first4,int last4){
;EE321_Lab6_V2.c,149 :: 		return (first4<<4) + last4;
	MOVLW      4
	MOVWF      R2+0
	MOVF       FARG_combineNumbers_first4+0, 0
	MOVWF      R0+0
	MOVF       FARG_combineNumbers_first4+1, 0
	MOVWF      R0+1
	MOVF       R2+0, 0
L__combineNumbers18:
	BTFSC      STATUS+0, 2
	GOTO       L__combineNumbers19
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__combineNumbers18
L__combineNumbers19:
	MOVF       FARG_combineNumbers_last4+0, 0
	ADDWF      R0+0, 1
	MOVF       FARG_combineNumbers_last4+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
;EE321_Lab6_V2.c,150 :: 		}
L_end_combineNumbers:
	RETURN
; end of _combineNumbers

_assignValues:

;EE321_Lab6_V2.c,152 :: 		void assignValues(int left,int middle,int right){
;EE321_Lab6_V2.c,154 :: 		PORTA = right;				// I'm using only last 4 digits
	MOVF       FARG_assignValues_right+0, 0
	MOVWF      PORTA+0
;EE321_Lab6_V2.c,155 :: 		PORTB = combineNumbers(left,middle);	// combine num2 and num3
	MOVF       FARG_assignValues_left+0, 0
	MOVWF      FARG_combineNumbers_first4+0
	MOVF       FARG_assignValues_left+1, 0
	MOVWF      FARG_combineNumbers_first4+1
	MOVF       FARG_assignValues_middle+0, 0
	MOVWF      FARG_combineNumbers_last4+0
	MOVF       FARG_assignValues_middle+1, 0
	MOVWF      FARG_combineNumbers_last4+1
	CALL       _combineNumbers+0
	MOVF       R0+0, 0
	MOVWF      PORTB+0
;EE321_Lab6_V2.c,156 :: 		}
L_end_assignValues:
	RETURN
; end of _assignValues

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;EE321_Lab6_V2.c,160 :: 		void interrupt(){
;EE321_Lab6_V2.c,161 :: 		increment();
	CALL       _increment+0
;EE321_Lab6_V2.c,164 :: 		TMR1L = 0xDB;	// Timer starts from counting
	MOVLW      219
	MOVWF      TMR1L+0
;EE321_Lab6_V2.c,165 :: 		TMR1H = 0x0B;	// Upper Limit of the count
	MOVLW      11
	MOVWF      TMR1H+0
;EE321_Lab6_V2.c,167 :: 		PIR1.TMR1IF = 0;
	BCF        PIR1+0, 0
;EE321_Lab6_V2.c,169 :: 		}
L_end_interrupt:
L__interrupt22:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt
