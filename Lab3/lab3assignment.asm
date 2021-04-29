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
movlw 0x02 ; or .2 for decimal assignment
movwf array+1
movlw 0x03 ; 3 for decimal assignment
movwf array+2
movlw 0x05 ; 5 for decimal assignment
movwf array+3
;Rest of the array
movlw .14
movwf array+4
movlw .15
movwf array+5
movlw .16
movwf array+6
movlw .114
movwf array+7
movlw .115
movwf array+8
movlw .200
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
btfsc STATUS,Z       ; test, skip or no skip
goto loopBottom      ; goto loopBottom


; fill here (1 line)
incf cnt,1           ; cnt++

loopBottom:


; fill here (1 line)
incf FSR,1           ; ptr++

; fill here (2 lines)
decfsz ii,1             ; if(--ii != 0)
goto loopTop         ;  goto loopTop



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