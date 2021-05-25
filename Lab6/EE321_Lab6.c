

// Initialize the variables
int num1 = 0; // 10   ms
int num2 = 0; // 100  ms
int isStart = 1; // start - stop button controller

// assign values to the ports
void assignValues(int left,int middle,int right);
// define combine numbers function
int combineNumbers(int num1,int num2);
// define reset function
void reset();
void increment();

void main(){

        // initialize the ports
        PCON.OSCF = 1;
        TRISA = 0xF0;
        TRISB = 0x00;
        PORTA = 0x00;
        PORTB = 0x00;

        while(1){

                // count every 10 ms
                delay_ms(10);

                increment();


        }

}


// reset all numbers and assign them
void reset(){
        num1 = 0;
        num2 = 0;
        assignValues(num2,num1,isStart);

}

void increment(){

        // if program clock is running
                if (isStart){

                        // increse the count
                        num1++;
                        // increase num2
                        if(num1 == 10){
                                num1 = 0;
                                num2++;
                        }// increase num 3
                        if (num2 == 10){
                                num2 = 0;
                        }
                        assignValues(num2,num1,isStart);
                }

}

int combineNumbers(int first4,int last4){
        return (first4<<4) + last4;
}

void assignValues(int left,int middle,int right){
        // Assign the values
                PORTA = right;                                // I'm using only last 4 digits
                PORTB = combineNumbers(left,middle);        // combine num2 and num3
}