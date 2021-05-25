#line 1 "C:/Users/Emin Kartci/Desktop/Courses/EE321_Lab/EE321_Lab6/EE321_Lab6.c"



int num1 = 0;
int num2 = 0;
int num3 = 0;
int isStart = 0;


void assignValues(int left,int middle,int right);

int combineNumbers(int num1,int num2);

void reset();
void increment();

void main(){


 PCON.OSCF = 1;
 TRISA = 0xF0;
 TRISB = 0x00;
 PORTA = 0x00;
 PORTB = 0x00;

 while(1){


 delay_ms(100);

 increment();


 }

}



void reset(){
 num1 = 0;
 num2 = 0;
 num3 = 0;
 assignValues(num3,num2,num1);

}

void increment(){


 if (isStart){


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

 assignValues(num3,num2,num1);
 }

}

int combineNumbers(int first4,int last4){
 return (first4<<4) + last4;
}

void assignValues(int left,int middle,int right){

 TRISA = right;
 PORTB = combineNumbers(left,middle);
}
