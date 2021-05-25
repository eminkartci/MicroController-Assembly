// This arduino reads the data from serial port and prints to LCD screen

// introducte lcd library
#include<LiquidCrystal.h>
// initialize lcd pins
LiquidCrystal lcd(12,11,5,4,3,2);

// Initialize variables
float sampledData = 0;
int Cval,Kval,Fval;

void setup() {
    // Initialize the screen as 16x2
      // 16 char
      // 2 rows
    lcd.begin(16,2);

    // Write Temperature at first
    lcd.print("Temperature");

    // Start serial communication
    Serial.begin(9600);
}

void loop() {

  // Sample data from Rx and convert float
  sampledData = Serial.parseFloat();

  // go next row of lcd screen
  lcd.setCursor(0,1);

  // write Celcius format
  Cval=(sampledData);
  lcd.print(Cval);
  lcd.print("C /");

  // Write Kelvin format
  Kval = Cval +273;
  lcd.print(Kval);
  lcd.print(" K/");

  // Write Fahreneit format
  Fval=(round)(Cval*9/5)+32;
  lcd.print(Fval);
  lcd.print("F");
  
  

}
