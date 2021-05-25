#line 1 "C:/Users/Emin Kartci/Desktop/Courses/EE321_Lab/EE321_Lab7/EE321_Lab7_EminKartci_PWMController.c"
#line 49 "C:/Users/Emin Kartci/Desktop/Courses/EE321_Lab/EE321_Lab7/EE321_Lab7_EminKartci_PWMController.c"
unsigned char statePWM = 0;
unsigned char mode=0;

void main(){

 TRISA =0x00;
 PORTB =0x00;

 PR2 = 20;

 CCPR1L = 0b00000101;
 CCP1CON |= 0b00010000;

 TRISB.F3 =0;

 T2CON.F0 =1;
 T2CON.F1 =1;
 T2CON.F2 =1;

 CCP1CON.CCP1M3=1;
 CCP1CON.CCP1M2=1;


 INTCON.GIE = 1;
 INTCON.RBIE = 1;
 INTCON.RBIF = 0;

 PORTA = 0x0A;



}


void interrupt(){



 if(RB4_bit==1){

 if(RA0_bit == 1){
 RA0_bit = 0;
 RA1_bit = 1;
 }
 else{
 RA0_bit = 1;
 RA1_bit = 0;
 }
 }

 if(RB5_bit==1){
 if(statePWM==0){
 statePWM=1;
 PR2 = 103;
 if(mode==0){
 CCPR1L = 0b00011010;
 CCP1CON |= 0b00000000;
 }
 else if (mode==1){
 CCPR1L = 0b00110100;
 CCP1CON |= 0b00000000;
 }
 else if (mode==2){

 CCPR1L = 0b01001110;
 CCP1CON |= 0b00000000;
 }
 }
 else if(statePWM==1){
 statePWM=0;
 PR2 = 20;
 if(mode==0){
 CCPR1L = 0b00000101;
 CCP1CON |= 0b00010000;
 }
 else if (mode==1){
 CCPR1L = 0b00001010;
 CCP1CON |= 0b00100000;
 }
 else if (mode==2){
 CCPR1L = 0b00001111;
 CCP1CON |= 0b00110000;
 }
 }
 }

 if(RB6_bit==1){
 mode++;
 if(mode>2)
 mode=0;
 }
 if(statePWM==0){
 if(mode==0){
 CCPR1L = 0b00000101;
 CCP1CON |= 0b00010000;
 }
 else if (mode==1){
 CCPR1L = 0b00001010;
 CCP1CON |= 0b00100000;
 }
 else if (mode==2){
 CCPR1L = 0b00001111;
 CCP1CON |= 0b00110000;
 }
 }
 else if(statePWM==1){
 if(mode==0){
 CCPR1L = 0b00011010;
 CCP1CON |= 0b00000000;
 }
 else if (mode==1){
 CCPR1L = 0b00110100;
 CCP1CON |= 0b00000000;
 }
 else if (mode==2){

 CCPR1L = 0b01001110;
 CCP1CON |= 0b00000000;
 }
 }


 INTCON.RBIF = 0;
}
