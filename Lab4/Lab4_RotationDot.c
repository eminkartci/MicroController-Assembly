unsigned char ledStatus = 8; // 8 means 0000 1000

void main() {

	PCON.OSCF = 1;		// Specific for each MIC
	CMCON     = 0x07;

	TRISA = 0xFF; // 1111 1111
	TRISB = 0x00; // 0000 0000

	PORTB = ledStatus; // Controls the led ports

	while(1) {

		if (RA0_bit == 0){
			ledStatus = ledStatus >> 1;  // Increase -> Right

			if(ledStatus == 0){
				ledStatus = 128;
			}
		}else{
			ledStatus = ledStatus << 1;  // Decrease -> Left

			if(ledStatus == 0){
				ledStatus = 1;
			}
		}



		PORTB = ledStatus;           // Renew Ports
		delay_ms(200); 				// Change is too fast slow it down
	}

}