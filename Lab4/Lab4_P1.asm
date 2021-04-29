
_main:

;EE321_Lab4_P1.c,7 :: 		void main() {
;EE321_Lab4_P1.c,9 :: 		PCON.OSCF = 1;		// Specific for each MIC
	BSF        PCON+0, 3
;EE321_Lab4_P1.c,10 :: 		CMCON     = 0x07;
	MOVLW      7
	MOVWF      CMCON+0
;EE321_Lab4_P1.c,12 :: 		TRISA = 0xFF; // 1111 1111
	MOVLW      255
	MOVWF      TRISA+0
;EE321_Lab4_P1.c,13 :: 		TRISB = 0x00; // 0000 0000
	CLRF       TRISB+0
;EE321_Lab4_P1.c,15 :: 		PORTB = ledStatus; // Controls the led ports
	MOVF       _ledStatus+0, 0
	MOVWF      PORTB+0
;EE321_Lab4_P1.c,19 :: 		while(1) {
L_main0:
;EE321_Lab4_P1.c,21 :: 		if (RA0_bit == 0){
	BTFSC      RA0_bit+0, BitPos(RA0_bit+0)
	GOTO       L_main2
;EE321_Lab4_P1.c,23 :: 		}else{
	GOTO       L_main3
L_main2:
;EE321_Lab4_P1.c,25 :: 		if(ledStatus == 128){// left edge
	MOVF       _ledStatus+0, 0
	XORLW      128
	BTFSS      STATUS+0, 2
	GOTO       L_main4
;EE321_Lab4_P1.c,26 :: 		rotation = 1; 		// change rotation to right
	MOVLW      1
	MOVWF      _rotation+0
	MOVLW      0
	MOVWF      _rotation+1
;EE321_Lab4_P1.c,27 :: 		}
L_main4:
;EE321_Lab4_P1.c,28 :: 		if(ledStatus == 0x01){// right edge
	MOVF       _ledStatus+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main5
;EE321_Lab4_P1.c,29 :: 		rotation = 0; 		// change rotation to left
	CLRF       _rotation+0
	CLRF       _rotation+1
;EE321_Lab4_P1.c,30 :: 		}
L_main5:
;EE321_Lab4_P1.c,33 :: 		if(rotation){
	MOVF       _rotation+0, 0
	IORWF      _rotation+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main6
;EE321_Lab4_P1.c,34 :: 		ledStatus = ledStatus >> 1;  // Increase -> Right
	RRF        _ledStatus+0, 1
	BCF        _ledStatus+0, 7
;EE321_Lab4_P1.c,35 :: 		}else{
	GOTO       L_main7
L_main6:
;EE321_Lab4_P1.c,36 :: 		ledStatus = ledStatus << 1;  // Decrease -> Left
	RLF        _ledStatus+0, 1
	BCF        _ledStatus+0, 0
;EE321_Lab4_P1.c,37 :: 		}
L_main7:
;EE321_Lab4_P1.c,38 :: 		}
L_main3:
;EE321_Lab4_P1.c,42 :: 		PORTB = ledStatus;           // Renew Ports
	MOVF       _ledStatus+0, 0
	MOVWF      PORTB+0
;EE321_Lab4_P1.c,43 :: 		delay_ms(100); 				// Change is too fast slow it down
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main8:
	DECFSZ     R13+0, 1
	GOTO       L_main8
	DECFSZ     R12+0, 1
	GOTO       L_main8
	DECFSZ     R11+0, 1
	GOTO       L_main8
	NOP
;EE321_Lab4_P1.c,44 :: 		}
	GOTO       L_main0
;EE321_Lab4_P1.c,46 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
