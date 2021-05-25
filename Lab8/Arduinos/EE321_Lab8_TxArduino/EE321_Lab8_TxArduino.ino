
// Initialize the output variable
float inputeTemp = 0,inputTempCel = 0;

void setup() {
  // Serial Communication 
  // This arduino will read data as analog
  // Calculate's C degree value
  // Send data via serial UART Port
  Serial.begin(9600); 

}

void loop() {

  // I connect my sensor to A1
  // Read data as analog from A1
  inputeTemp = analogRead(1);
  
  // Data should be mapped 
  // There are 1024 steps
  // step size is 10 mv (given in datasheet)
  // max V is 5V
  // Calculate the temp in terms of C degree
  inputTempCel=(inputeTemp/1023)*5000/10;

  // Send data by using serial port
  // Instead of casting as int use 'round' to increase the accuracy
  Serial.println((round)(inputTempCel));

  // We don't need to read data with high frequecy
  // it is optional
  delay(50);
}
