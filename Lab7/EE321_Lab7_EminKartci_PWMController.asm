
_main:

;EE321_Lab7_EminKartci_PWMController.c,52 :: 		void main(){
;EE321_Lab7_EminKartci_PWMController.c,54 :: 		TRISA		=0x00;
	CLRF       TRISA+0
;EE321_Lab7_EminKartci_PWMController.c,55 :: 		PORTB		=0x00;
	CLRF       PORTB+0
;EE321_Lab7_EminKartci_PWMController.c,57 :: 		PR2 		= 20;
	MOVLW      20
	MOVWF      PR2+0
;EE321_Lab7_EminKartci_PWMController.c,59 :: 		CCPR1L 		= 0b00000101;
	MOVLW      5
	MOVWF      CCPR1L+0
;EE321_Lab7_EminKartci_PWMController.c,60 :: 		CCP1CON 	|= 0b00010000;
	BSF        CCP1CON+0, 4
;EE321_Lab7_EminKartci_PWMController.c,62 :: 		TRISB.F3	=0;
	BCF        TRISB+0, 3
;EE321_Lab7_EminKartci_PWMController.c,64 :: 		T2CON.F0	=1;
	BSF        T2CON+0, 0
;EE321_Lab7_EminKartci_PWMController.c,65 :: 		T2CON.F1	=1;
	BSF        T2CON+0, 1
;EE321_Lab7_EminKartci_PWMController.c,66 :: 		T2CON.F2	=1;//Timer on
	BSF        T2CON+0, 2
;EE321_Lab7_EminKartci_PWMController.c,68 :: 		CCP1CON.CCP1M3=1;
	BSF        CCP1CON+0, 3
;EE321_Lab7_EminKartci_PWMController.c,69 :: 		CCP1CON.CCP1M2=1;
	BSF        CCP1CON+0, 2
;EE321_Lab7_EminKartci_PWMController.c,72 :: 		INTCON.GIE 	= 1;
	BSF        INTCON+0, 7
;EE321_Lab7_EminKartci_PWMController.c,73 :: 		INTCON.RBIE = 1;
	BSF        INTCON+0, 3
;EE321_Lab7_EminKartci_PWMController.c,74 :: 		INTCON.RBIF = 0;
	BCF        INTCON+0, 0
;EE321_Lab7_EminKartci_PWMController.c,76 :: 		PORTA 		= 0x0A;
	MOVLW      10
	MOVWF      PORTA+0
;EE321_Lab7_EminKartci_PWMController.c,80 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;EE321_Lab7_EminKartci_PWMController.c,83 :: 		void interrupt(){
;EE321_Lab7_EminKartci_PWMController.c,87 :: 		if(RB4_bit==1){
	BTFSS      RB4_bit+0, BitPos(RB4_bit+0)
	GOTO       L_interrupt0
;EE321_Lab7_EminKartci_PWMController.c,89 :: 		if(RA0_bit == 1){
	BTFSS      RA0_bit+0, BitPos(RA0_bit+0)
	GOTO       L_interrupt1
;EE321_Lab7_EminKartci_PWMController.c,90 :: 		RA0_bit = 0;
	BCF        RA0_bit+0, BitPos(RA0_bit+0)
;EE321_Lab7_EminKartci_PWMController.c,91 :: 		RA1_bit = 1;
	BSF        RA1_bit+0, BitPos(RA1_bit+0)
;EE321_Lab7_EminKartci_PWMController.c,92 :: 		}
	GOTO       L_interrupt2
L_interrupt1:
;EE321_Lab7_EminKartci_PWMController.c,94 :: 		RA0_bit = 1;
	BSF        RA0_bit+0, BitPos(RA0_bit+0)
;EE321_Lab7_EminKartci_PWMController.c,95 :: 		RA1_bit = 0;
	BCF        RA1_bit+0, BitPos(RA1_bit+0)
;EE321_Lab7_EminKartci_PWMController.c,96 :: 		}
L_interrupt2:
;EE321_Lab7_EminKartci_PWMController.c,97 :: 		}
L_interrupt0:
;EE321_Lab7_EminKartci_PWMController.c,99 :: 		if(RB5_bit==1){
	BTFSS      RB5_bit+0, BitPos(RB5_bit+0)
	GOTO       L_interrupt3
;EE321_Lab7_EminKartci_PWMController.c,100 :: 		if(statePWM==0){
	MOVF       _statePWM+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt4
;EE321_Lab7_EminKartci_PWMController.c,101 :: 		statePWM=1;
	MOVLW      1
	MOVWF      _statePWM+0
;EE321_Lab7_EminKartci_PWMController.c,102 :: 		PR2 = 103;//3KHz to do
	MOVLW      103
	MOVWF      PR2+0
;EE321_Lab7_EminKartci_PWMController.c,103 :: 		if(mode==0){//%25 to do
	MOVF       _mode+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt5
;EE321_Lab7_EminKartci_PWMController.c,104 :: 		CCPR1L = 0b00011010;
	MOVLW      26
	MOVWF      CCPR1L+0
;EE321_Lab7_EminKartci_PWMController.c,105 :: 		CCP1CON |= 0b00000000;
;EE321_Lab7_EminKartci_PWMController.c,106 :: 		}
	GOTO       L_interrupt6
L_interrupt5:
;EE321_Lab7_EminKartci_PWMController.c,107 :: 		else if (mode==1){//%50 to do
	MOVF       _mode+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt7
;EE321_Lab7_EminKartci_PWMController.c,108 :: 		CCPR1L = 0b00110100;
	MOVLW      52
	MOVWF      CCPR1L+0
;EE321_Lab7_EminKartci_PWMController.c,109 :: 		CCP1CON |= 0b00000000;
;EE321_Lab7_EminKartci_PWMController.c,110 :: 		}
	GOTO       L_interrupt8
L_interrupt7:
;EE321_Lab7_EminKartci_PWMController.c,111 :: 		else if (mode==2){//%75 to do
	MOVF       _mode+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt9
;EE321_Lab7_EminKartci_PWMController.c,113 :: 		CCPR1L = 0b01001110;
	MOVLW      78
	MOVWF      CCPR1L+0
;EE321_Lab7_EminKartci_PWMController.c,114 :: 		CCP1CON |= 0b00000000;
;EE321_Lab7_EminKartci_PWMController.c,115 :: 		}
L_interrupt9:
L_interrupt8:
L_interrupt6:
;EE321_Lab7_EminKartci_PWMController.c,116 :: 		}
	GOTO       L_interrupt10
L_interrupt4:
;EE321_Lab7_EminKartci_PWMController.c,117 :: 		else if(statePWM==1){
	MOVF       _statePWM+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt11
;EE321_Lab7_EminKartci_PWMController.c,118 :: 		statePWM=0;
	CLRF       _statePWM+0
;EE321_Lab7_EminKartci_PWMController.c,119 :: 		PR2 = 20;//15KHz to do
	MOVLW      20
	MOVWF      PR2+0
;EE321_Lab7_EminKartci_PWMController.c,120 :: 		if(mode==0){//%25 to do
	MOVF       _mode+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt12
;EE321_Lab7_EminKartci_PWMController.c,121 :: 		CCPR1L = 0b00000101;
	MOVLW      5
	MOVWF      CCPR1L+0
;EE321_Lab7_EminKartci_PWMController.c,122 :: 		CCP1CON |= 0b00010000;
	BSF        CCP1CON+0, 4
;EE321_Lab7_EminKartci_PWMController.c,123 :: 		}
	GOTO       L_interrupt13
L_interrupt12:
;EE321_Lab7_EminKartci_PWMController.c,124 :: 		else if (mode==1){//%50 to do
	MOVF       _mode+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt14
;EE321_Lab7_EminKartci_PWMController.c,125 :: 		CCPR1L = 0b00001010;
	MOVLW      10
	MOVWF      CCPR1L+0
;EE321_Lab7_EminKartci_PWMController.c,126 :: 		CCP1CON |= 0b00100000;
	BSF        CCP1CON+0, 5
;EE321_Lab7_EminKartci_PWMController.c,127 :: 		}
	GOTO       L_interrupt15
L_interrupt14:
;EE321_Lab7_EminKartci_PWMController.c,128 :: 		else if (mode==2){//%75 to do
	MOVF       _mode+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt16
;EE321_Lab7_EminKartci_PWMController.c,129 :: 		CCPR1L = 0b00001111;
	MOVLW      15
	MOVWF      CCPR1L+0
;EE321_Lab7_EminKartci_PWMController.c,130 :: 		CCP1CON |= 0b00110000;
	MOVLW      48
	IORWF      CCP1CON+0, 1
;EE321_Lab7_EminKartci_PWMController.c,131 :: 		}
L_interrupt16:
L_interrupt15:
L_interrupt13:
;EE321_Lab7_EminKartci_PWMController.c,132 :: 		}
L_interrupt11:
L_interrupt10:
;EE321_Lab7_EminKartci_PWMController.c,133 :: 		}
L_interrupt3:
;EE321_Lab7_EminKartci_PWMController.c,135 :: 		if(RB6_bit==1){
	BTFSS      RB6_bit+0, BitPos(RB6_bit+0)
	GOTO       L_interrupt17
;EE321_Lab7_EminKartci_PWMController.c,136 :: 		mode++;
	INCF       _mode+0, 1
;EE321_Lab7_EminKartci_PWMController.c,137 :: 		if(mode>2)
	MOVF       _mode+0, 0
	SUBLW      2
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt18
;EE321_Lab7_EminKartci_PWMController.c,138 :: 		mode=0;
	CLRF       _mode+0
L_interrupt18:
;EE321_Lab7_EminKartci_PWMController.c,139 :: 		}
L_interrupt17:
;EE321_Lab7_EminKartci_PWMController.c,140 :: 		if(statePWM==0){
	MOVF       _statePWM+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt19
;EE321_Lab7_EminKartci_PWMController.c,141 :: 		if(mode==0){//%25 to do
	MOVF       _mode+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt20
;EE321_Lab7_EminKartci_PWMController.c,142 :: 		CCPR1L = 0b00000101;
	MOVLW      5
	MOVWF      CCPR1L+0
;EE321_Lab7_EminKartci_PWMController.c,143 :: 		CCP1CON |= 0b00010000;
	BSF        CCP1CON+0, 4
;EE321_Lab7_EminKartci_PWMController.c,144 :: 		}
	GOTO       L_interrupt21
L_interrupt20:
;EE321_Lab7_EminKartci_PWMController.c,145 :: 		else if (mode==1){//%50 to do
	MOVF       _mode+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt22
;EE321_Lab7_EminKartci_PWMController.c,146 :: 		CCPR1L = 0b00001010;
	MOVLW      10
	MOVWF      CCPR1L+0
;EE321_Lab7_EminKartci_PWMController.c,147 :: 		CCP1CON |= 0b00100000;
	BSF        CCP1CON+0, 5
;EE321_Lab7_EminKartci_PWMController.c,148 :: 		}
	GOTO       L_interrupt23
L_interrupt22:
;EE321_Lab7_EminKartci_PWMController.c,149 :: 		else if (mode==2){//%75 to do
	MOVF       _mode+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt24
;EE321_Lab7_EminKartci_PWMController.c,150 :: 		CCPR1L = 0b00001111;
	MOVLW      15
	MOVWF      CCPR1L+0
;EE321_Lab7_EminKartci_PWMController.c,151 :: 		CCP1CON |= 0b00110000;
	MOVLW      48
	IORWF      CCP1CON+0, 1
;EE321_Lab7_EminKartci_PWMController.c,152 :: 		}
L_interrupt24:
L_interrupt23:
L_interrupt21:
;EE321_Lab7_EminKartci_PWMController.c,153 :: 		}
	GOTO       L_interrupt25
L_interrupt19:
;EE321_Lab7_EminKartci_PWMController.c,154 :: 		else if(statePWM==1){
	MOVF       _statePWM+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt26
;EE321_Lab7_EminKartci_PWMController.c,155 :: 		if(mode==0){//%25 to do
	MOVF       _mode+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt27
;EE321_Lab7_EminKartci_PWMController.c,156 :: 		CCPR1L = 0b00011010;
	MOVLW      26
	MOVWF      CCPR1L+0
;EE321_Lab7_EminKartci_PWMController.c,157 :: 		CCP1CON |= 0b00000000;
;EE321_Lab7_EminKartci_PWMController.c,158 :: 		}
	GOTO       L_interrupt28
L_interrupt27:
;EE321_Lab7_EminKartci_PWMController.c,159 :: 		else if (mode==1){//%50 to do
	MOVF       _mode+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt29
;EE321_Lab7_EminKartci_PWMController.c,160 :: 		CCPR1L = 0b00110100;
	MOVLW      52
	MOVWF      CCPR1L+0
;EE321_Lab7_EminKartci_PWMController.c,161 :: 		CCP1CON |= 0b00000000;
;EE321_Lab7_EminKartci_PWMController.c,162 :: 		}
	GOTO       L_interrupt30
L_interrupt29:
;EE321_Lab7_EminKartci_PWMController.c,163 :: 		else if (mode==2){//%75 to do
	MOVF       _mode+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt31
;EE321_Lab7_EminKartci_PWMController.c,165 :: 		CCPR1L = 0b01001110;
	MOVLW      78
	MOVWF      CCPR1L+0
;EE321_Lab7_EminKartci_PWMController.c,166 :: 		CCP1CON |= 0b00000000;
;EE321_Lab7_EminKartci_PWMController.c,167 :: 		}
L_interrupt31:
L_interrupt30:
L_interrupt28:
;EE321_Lab7_EminKartci_PWMController.c,168 :: 		}
L_interrupt26:
L_interrupt25:
;EE321_Lab7_EminKartci_PWMController.c,171 :: 		INTCON.RBIF = 0;
	BCF        INTCON+0, 0
;EE321_Lab7_EminKartci_PWMController.c,172 :: 		}
L_end_interrupt:
L__interrupt34:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt
