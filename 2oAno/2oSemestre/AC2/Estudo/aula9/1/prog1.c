# include <detpic32.h>

volatile unsigned int voltage;

void delay(int ms) {
    resetCoreTimer();
    while(readCoreTimer() < PBCLK/1000 * ms);
}



void send2displays(unsigned char value) {
    unsigned int digitLow, digitHigh;
    static char displayFlag = 0;

    static int display7Scodes[] = {0x3F, 0x06, 0x5b, 0x4F, 0x66, 0x6D, 0x7D,
0x07, 0x7F, 0x6F, 0x77,0x7C,0x39, 0x5E,0x79,0x71};  

    digitLow = value & 0x0F;
    digitHigh = value >> 4;

    if(displayFlag) {
        // 1111 1111 1001 1111
        LATD = (LATD & 0xFF9F) | 0x0020;        // select lower display
        LATB = (LATE & 0x80FF) | (display7Scodes[digitLow] << 8);
    } else {
        LATD = (LATD & 0xFF9F) | 0x0040;
        LATB = (LATE & 0x80FF) | (display7Scodes[digitHigh] << 8);
    }

    displayFlag = !displayFlag;
}



unsigned char toBcd(unsigned char value) {   
   return ((value / 10) << 4) + (value % 10); 
}



int main(void) {
    TRISD = (TRISD & 0xFF9F);
    TRISB = (TRISB & 0x80FF);

    TRISBbits.TRISB4 = 1;       // RBx digital output disconnected 
    AD1PCFGbits.PCFG4= 0;       // RBx configured as analog input 
    AD1CON1bits.SSRC = 7;       // Conversion trigger selection bits: in this 
                                //  mode an internal counter ends sampling and 
                                //  starts conversion 
    AD1CON1bits.CLRASAM = 1;    // Stop conversions when the 1st A/D converter 
                                //  interrupt is generated. At the same time, 
                                //  hardware clears the ASAM bit 
    AD1CON3bits.SAMC = 16;      // Sample time is 16 TAD (TAD = 100 ns) 
    AD1CON2bits.SMPI = 8-1;     // Interrupt is generated after N samples 
                                //  (replace N by the desired number of 
                                //  consecutive samples) 
    AD1CHSbits.CH0SA = 4;       // replace x by the desired input  
                                //  analog channel (0 to 15) 
    AD1CON1bits.ON = 1;         // Enable A/D converter 
                                //  This must the last command of the A/D 
                                //  configuration sequence

// from this exercise
    // config adc for interruptions
    IPC6bits.AD1IP = 2;  // configure priority of A/D interrupts
    IFS1bits.AD1IF = 0;  // clear A/D interrupt flag
    IEC1bits.AD1IE = 1;  // enable A/D interrupts

    // config timer 1
    // 1 8 64 256
    T1CONbits.TCKPS = 2;    // (n = 5 -> 32) 1:32 prescaler (i.e. fout_presc = 625 KHz)
    PR1 = 62499;            // Fout = 20MHz / (32 * (62499 + 1)) = 10 Hz 
    TMR1 = 0;               // Clear timer T2 count register 
    T1CONbits.TON = 1;      // Enable timer T2 (must be the last command of the 
                            //  timer configuration sequence)
    // config timer for interruptions
    IPC1bits.T1IP = 2;      // Interrupt priority (must be in range [1..6]) 
    IEC0bits.T1IE = 1;      // Enable timer T2 interrupts 
    IFS0bits.T1IF = 0;      // Reset timer T2 interrupt flag

    // 1 2 4 8 16 32 64 256
    // config timer 3
    T3CONbits.TCKPS = 2;    // (n = 5 -> 32) 1:32 prescaler (i.e. fout_presc = 625 KHz)
    PR3 = 49999;            // Fout = 20MHz / (32 * (62499 + 1)) = 10 Hz 
    TMR3 = 0;               // Clear timer T2 count register 
    T3CONbits.TON = 1;      // Enable timer T2 (must be the last command of the 
                            //  timer configuration sequence)
    // config timer for interruptions
    IPC3bits.T3IP = 2; // Interrupt priority (must be in range [1..6]) 
    IEC0bits.T3IE = 1; // Enable timer T2 interrupts 
    IFS0bits.T3IF = 0; // Reset timer T2 interrupt flag
//
    EnableInterrupts();

    while(1);
    return 0;
}


void _int_(4) isr_t1(void) {
    AD1CON1bits.ASAM = 1;       // start conversion
    IFS0bits.T1IF = 0;          // reset interrupt flag
}



void _int_(12) isr_t3(void) {
    send2displays(toBcd(voltage));
    IFS0bits.T3IF = 0;          // reset interrupt flag
}



void _int_(27) isr_adc(void) {
    int i, valMedio = 0;

    int* p = (int*)(&ADC1BUF0);

    for(i=0; i < 8; i++) {
        valMedio += p[i*4];
    }

    valMedio = valMedio / 8;

    voltage = (valMedio*33 + 511)/1023;

    IFS1bits.AD1IF = 0;
}
