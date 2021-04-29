list      p=16f628A           ; list directive to define processor
#include <p16F628A.inc>       ; processor specific variable definitions
__CONFIG _INTRC_OSC_NOCLKOUT & _WDT_OFF

num EQU 0x20
array EQU 0x21
cnt EQU 0x35

; num = 10
movlw 0xA
movwf num
; array[10]={200,2,3,5,14,15,16,114,115,200};
movlw 0xC8 ; or .200 for decimal assignment
movwf array
movlw 0x2 ; or .2 for decimal assignment
movwf array+1
movlw 0x03 ; 3 for decimal assignment
movwf array+2
movlw 0x05 ; 5 for decimal assignment
movwf array+3
movlw 0xE ; 14 for decimal assignment
movwf array+4
movlw 0xF ; 15 for decimal assignment
movwf array+5
movlw 0x10 ;16 for decimal assignment
movwf array+6
movlw 0x72 ;114 for decimal assignment
movwf array+7
movlw 0x73 ;115 for decimal assignment
movwf array+8
movlw 0xC8 ;200 for decimal assignment
movwf array+9


; cnt=0;
movlw 0
movwf cnt

ii EQU 0x36
; ii = 10
movlw 0xA
movwf ii

; Your tasks start here...
movlw array ; start point
movwf FSR

loopTop:

; if((array[ii] & 0x01) == 0)
; fill here (4 lines)
movlw 0x01           ; 0x01 -> w
andwf INDF,0         ; 0x01 & array[ii], HINT:INDF
btfsc STATUS,Z         ; test, skip or no skip

GOTO loopBottom          ; goto loopBottom


; fill here (1 line)
INCF cnt,1           ; cnt++

loopBottom:


; fill here (1 line)
INCF ptr,1           ; ptr++

; fill here (2 lines)
DECFSZ ii,0             ; if(--ii != 0)
GOTO loopTop         ;  goto loopTop



; that's it ...

clrf PORTB
banksel TRISB
clrf TRISB
banksel PORTB

movf  cnt, w
movwf PORTB
; return
progEnd: goto progEnd

end