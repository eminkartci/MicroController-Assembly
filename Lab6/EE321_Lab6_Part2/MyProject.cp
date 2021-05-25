#line 1 "C:/Users/Emin Kartci/Desktop/Courses/EE321_Lab/EE321_Lab6/EE321_Lab6_Part2/MyProject.c"







int num1 = 0;
int num2 = 0;
int num3 = 0;
int state = 0;
int buttonP = 0;

void displayNum1(int);
void displayNum2(int);
void displayNum3(int);
void increment();
void reset();

void main(){


 PCON.OSCF = 1;
 TRISA = 0xF0;
 TRISB = 0x00;
 PORTA = 0x00;
 PORTB = 0x00;

 while(1){

 delay_ms(50);


 if( buttonP == 0 && RA5_bit == 1){
 state = (state == 9 ? 0 : state+1);
 }

 buttonP = RA5_bit;


 if (RA6_bit == 1 ){

 reset();
 }


 if(state==1){
 increment();
 }


 displayNum1(num1);
 delay_ms(3);
 displayNum2(num2);
 delay_ms(3);
 displayNum3(num3);
 }

}
void increment(){


 num1++;


 if(num1 == 10){
 num1 = 0;
 num2++;
 }
 if (num2 == 10){
 num2 = 0;
 num3++;
 }
 if(num3 == 10){
 reset();
 }

}


void reset(){
 num1 = 0;
 num2 = 0;
 num3 = 0;
 state = 0;

}

void displayNum1(int num1) {
 PORTA = 0x06;
 PORTB = num1;
}


void displayNum2(int num2) {
 PORTA = 0x05;
 PORTB = num2;
}

void displayNum3(int num3) {
 PORTA = 0x03;
 PORTB = num3;
}
