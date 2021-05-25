
_main:

;MyProject.c,20 :: 		void main(){
;MyProject.c,23 :: 		PCON.OSCF = 1;
	BSF        PCON+0, 3
;MyProject.c,24 :: 		TRISA = 0xF0;
	MOVLW      240
	MOVWF      TRISA+0
;MyProject.c,25 :: 		TRISB = 0x00;
	CLRF       TRISB+0
;MyProject.c,26 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,27 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,29 :: 		while(1){
L_main0:
;MyProject.c,31 :: 		delay_ms(50);
	MOVLW      17
	MOVWF      R12+0
	MOVLW      58
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	DECFSZ     R12+0, 1
	GOTO       L_main2
	NOP
;MyProject.c,34 :: 		if( buttonP == 0 && RA5_bit == 1){
	MOVLW      0
	XORWF      _buttonP+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main17
	MOVLW      0
	XORWF      _buttonP+0, 0
L__main17:
	BTFSS      STATUS+0, 2
	GOTO       L_main5
	BTFSS      RA5_bit+0, BitPos(RA5_bit+0)
	GOTO       L_main5
L__main15:
;MyProject.c,35 :: 		state = (state == 9 ? 0 : state+1); // short if block
	MOVLW      0
	XORWF      _state+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main18
	MOVLW      9
	XORWF      _state+0, 0
L__main18:
	BTFSS      STATUS+0, 2
	GOTO       L_main6
	CLRF       ?FLOC___mainT6+0
	CLRF       ?FLOC___mainT6+1
	GOTO       L_main7
L_main6:
	MOVF       _state+0, 0
	ADDLW      1
	MOVWF      ?FLOC___mainT6+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _state+1, 0
	MOVWF      ?FLOC___mainT6+1
L_main7:
	MOVF       ?FLOC___mainT6+0, 0
	MOVWF      _state+0
	MOVF       ?FLOC___mainT6+1, 0
	MOVWF      _state+1
;MyProject.c,36 :: 		}
L_main5:
;MyProject.c,38 :: 		buttonP = RA5_bit; // Previous value
	MOVLW      0
	BTFSC      RA5_bit+0, BitPos(RA5_bit+0)
	MOVLW      1
	MOVWF      _buttonP+0
	CLRF       _buttonP+1
;MyProject.c,41 :: 		if (RA6_bit == 1 ){
	BTFSS      RA6_bit+0, BitPos(RA6_bit+0)
	GOTO       L_main8
;MyProject.c,43 :: 		reset();
	CALL       _reset+0
;MyProject.c,44 :: 		}
L_main8:
;MyProject.c,47 :: 		if(state==1){
	MOVLW      0
	XORWF      _state+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main19
	MOVLW      1
	XORWF      _state+0, 0
L__main19:
	BTFSS      STATUS+0, 2
	GOTO       L_main9
;MyProject.c,48 :: 		increment();
	CALL       _increment+0
;MyProject.c,49 :: 		}
L_main9:
;MyProject.c,52 :: 		displayNum1(num1);
	MOVF       _num1+0, 0
	MOVWF      FARG_displayNum1+0
	MOVF       _num1+1, 0
	MOVWF      FARG_displayNum1+1
	CALL       _displayNum1+0
;MyProject.c,53 :: 		delay_ms(3);
	MOVLW      249
	MOVWF      R13+0
L_main10:
	DECFSZ     R13+0, 1
	GOTO       L_main10
	NOP
	NOP
;MyProject.c,54 :: 		displayNum2(num2);
	MOVF       _num2+0, 0
	MOVWF      FARG_displayNum2+0
	MOVF       _num2+1, 0
	MOVWF      FARG_displayNum2+1
	CALL       _displayNum2+0
;MyProject.c,55 :: 		delay_ms(3);
	MOVLW      249
	MOVWF      R13+0
L_main11:
	DECFSZ     R13+0, 1
	GOTO       L_main11
	NOP
	NOP
;MyProject.c,56 :: 		displayNum3(num3);
	MOVF       _num3+0, 0
	MOVWF      FARG_displayNum3+0
	MOVF       _num3+1, 0
	MOVWF      FARG_displayNum3+1
	CALL       _displayNum3+0
;MyProject.c,57 :: 		}
	GOTO       L_main0
;MyProject.c,59 :: 		}//SAME LAB5
L_end_main:
	GOTO       $+0
; end of _main

_increment:

;MyProject.c,60 :: 		void increment(){
;MyProject.c,63 :: 		num1++;
	INCF       _num1+0, 1
	BTFSC      STATUS+0, 2
	INCF       _num1+1, 1
;MyProject.c,66 :: 		if(num1 == 10){
	MOVLW      0
	XORWF      _num1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__increment21
	MOVLW      10
	XORWF      _num1+0, 0
L__increment21:
	BTFSS      STATUS+0, 2
	GOTO       L_increment12
;MyProject.c,67 :: 		num1 = 0;
	CLRF       _num1+0
	CLRF       _num1+1
;MyProject.c,68 :: 		num2++;
	INCF       _num2+0, 1
	BTFSC      STATUS+0, 2
	INCF       _num2+1, 1
;MyProject.c,69 :: 		}// increase num 3
L_increment12:
;MyProject.c,70 :: 		if (num2 == 10){
	MOVLW      0
	XORWF      _num2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__increment22
	MOVLW      10
	XORWF      _num2+0, 0
L__increment22:
	BTFSS      STATUS+0, 2
	GOTO       L_increment13
;MyProject.c,71 :: 		num2 = 0;
	CLRF       _num2+0
	CLRF       _num2+1
;MyProject.c,72 :: 		num3++;
	INCF       _num3+0, 1
	BTFSC      STATUS+0, 2
	INCF       _num3+1, 1
;MyProject.c,73 :: 		} // reset clock
L_increment13:
;MyProject.c,74 :: 		if(num3 == 10){
	MOVLW      0
	XORWF      _num3+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__increment23
	MOVLW      10
	XORWF      _num3+0, 0
L__increment23:
	BTFSS      STATUS+0, 2
	GOTO       L_increment14
;MyProject.c,75 :: 		reset();
	CALL       _reset+0
;MyProject.c,76 :: 		}
L_increment14:
;MyProject.c,78 :: 		}
L_end_increment:
	RETURN
; end of _increment

_reset:

;MyProject.c,81 :: 		void reset(){
;MyProject.c,82 :: 		num1 = 0;
	CLRF       _num1+0
	CLRF       _num1+1
;MyProject.c,83 :: 		num2 = 0;
	CLRF       _num2+0
	CLRF       _num2+1
;MyProject.c,84 :: 		num3 = 0;
	CLRF       _num3+0
	CLRF       _num3+1
;MyProject.c,85 :: 		state = 0;
	CLRF       _state+0
	CLRF       _state+1
;MyProject.c,87 :: 		}
L_end_reset:
	RETURN
; end of _reset

_displayNum1:

;MyProject.c,89 :: 		void displayNum1(int num1) {
;MyProject.c,90 :: 		PORTA = 0x06;//00000110
	MOVLW      6
	MOVWF      PORTA+0
;MyProject.c,91 :: 		PORTB = num1;
	MOVF       FARG_displayNum1_num1+0, 0
	MOVWF      PORTB+0
;MyProject.c,92 :: 		}
L_end_displayNum1:
	RETURN
; end of _displayNum1

_displayNum2:

;MyProject.c,95 :: 		void displayNum2(int num2) {
;MyProject.c,96 :: 		PORTA = 0x05;//00000101
	MOVLW      5
	MOVWF      PORTA+0
;MyProject.c,97 :: 		PORTB = num2;
	MOVF       FARG_displayNum2_num2+0, 0
	MOVWF      PORTB+0
;MyProject.c,98 :: 		}
L_end_displayNum2:
	RETURN
; end of _displayNum2

_displayNum3:

;MyProject.c,100 :: 		void displayNum3(int num3) {
;MyProject.c,101 :: 		PORTA = 0x03;//00000011
	MOVLW      3
	MOVWF      PORTA+0
;MyProject.c,102 :: 		PORTB = num3;
	MOVF       FARG_displayNum3_num3+0, 0
	MOVWF      PORTB+0
;MyProject.c,103 :: 		}
L_end_displayNum3:
	RETURN
; end of _displayNum3
