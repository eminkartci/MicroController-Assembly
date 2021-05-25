#line 1 "C:/Users/Emin Kartci/Desktop/Courses/EE321_Lab/EE321_Lab6/EE321_Lab6_V2.c"
#line 40 "C:/Users/Emin Kartci/Desktop/Courses/EE321_Lab/EE321_Lab6/EE321_Lab6_V2.c"
int num1 = 0;
int num2 = 0;
int state = 0;
unsigned char buttonP = 0;


void assignValues(int left,int middle,int right);

int combineNumbers(int num1,int num2);

void reset();
void increment();


void interrupt();



void main(){


 PCON.OSCF = 1;
 TRISA = 0xF0;
 TRISB = 0x00;
 PORTA = 0x00;
 PORTB = 0x00;




 T1CON.T1CKPS0 = 0;
 T1CON.T1CKPS1 = 1;


 T1CON.TMR1CS = 0;

 TMR1L = 0xDB;
 TMR1H = 0X0B;

 T1CON.TMR1ON = 1;






 INTCON.GIE = 1;
 PIE1.TMR1IE = 1;
 INTCON.PEIE = 1;

 while(1){
#line 105 "C:/Users/Emin Kartci/Desktop/Courses/EE321_Lab/EE321_Lab6/EE321_Lab6_V2.c"
 if( buttonP == 0 && RA5_bit == 1){
 state = (state == 9 ? 0 : state+1);
 }

 buttonP = RA5_bit;


 if (RA6_bit == 1 ){

 reset();
 }


 assignValues(state,num1,num2);

 }

}


void reset(){

 state= 0;

}

void increment(){



 num1++;

 if(num1 == 10){
 num1 = 0;
 num2++;

 if (num2 == 10){
 num2 = 0;
 }
 }

}

int combineNumbers(int first4,int last4){
 return (first4<<4) + last4;
}

void assignValues(int left,int middle,int right){

 PORTA = right;
 PORTB = combineNumbers(left,middle);
}



void interrupt(){
 increment();


 TMR1L = 0xDB;
 TMR1H = 0x0B;

 PIR1.TMR1IF = 0;

}
