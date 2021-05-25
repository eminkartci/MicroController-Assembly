
_main:

;EE321_Lab6.c,17 :: 		void main(){
;EE321_Lab6.c,20 :: 		PCON.OSCF = 1;
	BSF        PCON+0, 3
;EE321_Lab6.c,21 :: 		TRISA = 0xF0;
	MOVLW      240
	MOVWF      TRISA+0
;EE321_Lab6.c,22 :: 		TRISB = 0x00;
	CLRF       TRISB+0
;EE321_Lab6.c,23 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;EE321_Lab6.c,24 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;EE321_Lab6.c,26 :: 		while(1){
L_main0:
;EE321_Lab6.c,29 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	DECFSZ     R12+0, 1
	GOTO       L_main2
	DECFSZ     R11+0, 1
	GOTO       L_main2
	NOP
;EE321_Lab6.c,31 :: 		increment();
	CALL       _increment+0
;EE321_Lab6.c,34 :: 		}
	GOTO       L_main0
;EE321_Lab6.c,36 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_reset:

;EE321_Lab6.c,40 :: 		void reset(){
;EE321_Lab6.c,41 :: 		num1 = 0;
	CLRF       _num1+0
	CLRF       _num1+1
;EE321_Lab6.c,42 :: 		num2 = 0;
	CLRF       _num2+0
	CLRF       _num2+1
;EE321_Lab6.c,43 :: 		num3 = 0;
	CLRF       _num3+0
	CLRF       _num3+1
;EE321_Lab6.c,44 :: 		assignValues(num3,num2,num1);
	CLRF       FARG_assignValues_left+0
	CLRF       FARG_assignValues_left+1
	CLRF       FARG_assignValues_middle+0
	CLRF       FARG_assignValues_middle+1
	CLRF       FARG_assignValues_right+0
	CLRF       FARG_assignValues_right+1
	CALL       _assignValues+0
;EE321_Lab6.c,46 :: 		}
L_end_reset:
	RETURN
; end of _reset

_increment:

;EE321_Lab6.c,48 :: 		void increment(){
;EE321_Lab6.c,51 :: 		if (isStart){
	MOVF       _isStart+0, 0
	IORWF      _isStart+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_increment3
;EE321_Lab6.c,54 :: 		num1++;
	INCF       _num1+0, 1
	BTFSC      STATUS+0, 2
	INCF       _num1+1, 1
;EE321_Lab6.c,56 :: 		if(num1 == 10){
	MOVLW      0
	XORWF      _num1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__increment10
	MOVLW      10
	XORWF      _num1+0, 0
L__increment10:
	BTFSS      STATUS+0, 2
	GOTO       L_increment4
;EE321_Lab6.c,57 :: 		num1 = 0;
	CLRF       _num1+0
	CLRF       _num1+1
;EE321_Lab6.c,58 :: 		num2++;
	INCF       _num2+0, 1
	BTFSC      STATUS+0, 2
	INCF       _num2+1, 1
;EE321_Lab6.c,59 :: 		}// increase num 3
L_increment4:
;EE321_Lab6.c,60 :: 		if (num2 == 10){
	MOVLW      0
	XORWF      _num2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__increment11
	MOVLW      10
	XORWF      _num2+0, 0
L__increment11:
	BTFSS      STATUS+0, 2
	GOTO       L_increment5
;EE321_Lab6.c,61 :: 		num2 = 0;
	CLRF       _num2+0
	CLRF       _num2+1
;EE321_Lab6.c,62 :: 		num3++;
	INCF       _num3+0, 1
	BTFSC      STATUS+0, 2
	INCF       _num3+1, 1
;EE321_Lab6.c,63 :: 		} // reset clock
L_increment5:
;EE321_Lab6.c,64 :: 		if(num3 == 10){
	MOVLW      0
	XORWF      _num3+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__increment12
	MOVLW      10
	XORWF      _num3+0, 0
L__increment12:
	BTFSS      STATUS+0, 2
	GOTO       L_increment6
;EE321_Lab6.c,65 :: 		reset();
	CALL       _reset+0
;EE321_Lab6.c,66 :: 		}
L_increment6:
;EE321_Lab6.c,68 :: 		assignValues(num3,num2,num1);
	MOVF       _num3+0, 0
	MOVWF      FARG_assignValues_left+0
	MOVF       _num3+1, 0
	MOVWF      FARG_assignValues_left+1
	MOVF       _num2+0, 0
	MOVWF      FARG_assignValues_middle+0
	MOVF       _num2+1, 0
	MOVWF      FARG_assignValues_middle+1
	MOVF       _num1+0, 0
	MOVWF      FARG_assignValues_right+0
	MOVF       _num1+1, 0
	MOVWF      FARG_assignValues_right+1
	CALL       _assignValues+0
;EE321_Lab6.c,69 :: 		}
L_increment3:
;EE321_Lab6.c,71 :: 		}
L_end_increment:
	RETURN
; end of _increment

_combineNumbers:

;EE321_Lab6.c,73 :: 		int combineNumbers(int first4,int last4){
;EE321_Lab6.c,74 :: 		return (first4<<4) + last4;
	MOVLW      4
	MOVWF      R2+0
	MOVF       FARG_combineNumbers_first4+0, 0
	MOVWF      R0+0
	MOVF       FARG_combineNumbers_first4+1, 0
	MOVWF      R0+1
	MOVF       R2+0, 0
L__combineNumbers14:
	BTFSC      STATUS+0, 2
	GOTO       L__combineNumbers15
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__combineNumbers14
L__combineNumbers15:
	MOVF       FARG_combineNumbers_last4+0, 0
	ADDWF      R0+0, 1
	MOVF       FARG_combineNumbers_last4+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
;EE321_Lab6.c,75 :: 		}
L_end_combineNumbers:
	RETURN
; end of _combineNumbers

_assignValues:

;EE321_Lab6.c,77 :: 		void assignValues(int left,int middle,int right){
;EE321_Lab6.c,79 :: 		TRISA = right;				// I'm using only last 4 digits
	MOVF       FARG_assignValues_right+0, 0
	MOVWF      TRISA+0
;EE321_Lab6.c,80 :: 		PORTB = combineNumbers(left,middle);	// combine num2 and num3
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
;EE321_Lab6.c,81 :: 		}
L_end_assignValues:
	RETURN
; end of _assignValues
