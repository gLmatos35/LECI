# include <detpic32.h>

unsigned char toBcd(unsigned char value) {
    return ((value / 10) << 4) + (value % 10);
}

void send2displays(unsigned char value) {
    unsigned int dl, dh;

    static const int display7Scodes[16] = {0x3F, 0x06, 0x5b, 0x4F, 0x66, 0x6D, 0x7D,
0x07, 0x7F, 0x6F, 0x77,0x7C,0x39, 0x5E,0x79,0x71};  
    
    static char displayFlag = 0;
    dl = value & 0x0F;
    dh = value >> 4;

    if(displayFlag == 0) {
        LATD = (LATD & 0xFF9F) | 0x0020;        // select lower display
        LATB = (LATB & 0x80FF) | (display7Scodes[dl] << 8);
    } else {
        LATD = (LATD & 0xFF9F) | 0x0040;
        LATB = (LATB & 0x80FF) | (display7Scodes[dh] << 8);
    }

    displayFlag = !displayFlag;
}

volatile unsigned int voltage;

int main(void) {
    TRISD = (TRISD & 0xFF9F);
    TRISB = (TRISB & 0x80FF);

    TRISBbits.TRISB4 = 1;   // RBx digital output disconnected
    AD1PCFGbits.PCFG4= 0;   // RBx configured as analog input
    AD1CON1bits.SSRC = 7;   // Conversion trigger selection bits: in this
    AD1CON1bits.CLRASAM = 1; // Stop conversions when the 1st A/D converter
    AD1CON3bits.SAMC = 16;  // Sample time is 16 TAD (TAD = 100 ns)
    AD1CON2bits.SMPI = 2-1; // Interrupt is generated after N samples
    AD1CHSbits.CH0SA = 4;   // replace x by the desired input
    AD1CON1bits.ON = 1;     // Enable A/D converter

    T3CONbits.TCKPS = 1;    // 1:2 prescaler (i.e. fout_presc = 625 KHz)
    PR3 = 39999;            // Fout = 20MHz / (2 * (39999 + 1)) = 250Hz
    TMR3 = 0;               // Clear timer T2 count register
    T3CONbits.TON = 1;      // Enable timer T2 (must be the last command of the
    // config t3 for interruptions
    IPC3bits.T3IP = 2;      // Interrupt priority (must be in range [1..6])
    IEC0bits.T3IE = 1;      // Enable timer T2 interrupts
    IFS0bits.T3IF = 0;      // Reset timer T2 interrupt flag

    EnableInterrupts();
    while(1) {
        AD1CON1bits.ASAM = 1;       // start conversion
        while(IFS1bits.AD1IF == 0); // Wait while conversion not done

        int *p = (int*)(&ADC1BUF0);
        int i, valMedio = 0;
        for(i=0; i < 2; i++) {
            valMedio += p[i*4];
        }
        valMedio /= 2;
        voltage = (valMedio*66 + 511)/1023;
        voltage += 7;

        IFS1bits.AD1IF = 0;     // reset flag
        resetCoreTimer();
        while(readCoreTimer() < 4000000);
    }
    return 0;
}

void _int_(12) isr_t3(void) {
    send2displays(toBcd(voltage));
    IFS0bits.T3IF = 0;      // reset flag
}
