unsigned char ledStatus = 8; // 8 means 0000 1000

unsigned int rotation = 1;
// rotation 0 -> left
// rotation 1 -> right

void main() {
	
	PCON.OSCF = 1;		// Specific for each MIC
	CMCON     = 0x07;
	
	TRISA = 0xFF; // 1111 1111
	TRISB = 0x00; // 0000 0000
	
	PORTB = ledStatus; // Controls the led ports
	
	
		
	while(1) {

		if (RA0_bit == 0){
			// Stay - Do Nothing
		}else{
			
			if(ledStatus == 128){// left edge
				rotation = 1; 		// change rotation to right
			}
			if(ledStatus == 0x01){// right edge
				rotation = 0; 		// change rotation to left
			}
			
			
			if(rotation){
				ledStatus = ledStatus >> 1;  // Increase -> Right
			}else{
				ledStatus = ledStatus << 1;  // Decrease -> Left
			}
		}
		
		
		
		PORTB = ledStatus;           // Renew Ports
		delay_ms(100); 				// Change is too fast slow it down
	}
	
}