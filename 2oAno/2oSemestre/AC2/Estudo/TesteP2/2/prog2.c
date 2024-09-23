# include <detpic32.h>

volatile unsigned int voltage;

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

int main(void) {
    int i;
    
    // config ADC
    TRISBbits.TRISB4 = 1;       // RB4 configured as analog input
    AD1PCFGbits.PCFG4= 0;       // Conversion trigger selection bits: in this
    AD1CON1bits.SSRC = 7;       // mode an internal counter ends sampling and starts converison
    
    AD1CON1bits.CLRASAM = 1;    // Stop conversions when the 1st A/D converter
    AD1CON3bits.SAMC = 16;      // Sample time is 16 TAD (TAD = 100 ns)
    AD1CON2bits.SMPI = 2-1;     // N samples (2)
    AD1CHSbits.CH0SA = 4;       // replace x by the desired input analog channel (0 to 15)
    AD1CON1bits.ON = 1;         // Enable A/D converter

    // config Timer 3 -> 250Hz
    T3CONbits.TCKPS = 1;    // 1:2 prescaler
    PR3 = 39999;            // Fout = 20MHz / (2 * (39999 + 1)) = 250 Hz 
    TMR3 = 0;               // Clear timer T3 count register 
    T3CONbits.TON = 1;      // Enable timer T3 (must be the last command of the 
                            //  timer configuration sequence)
    // config timer for interruptions
    IPC3bits.T3IP = 2; // Interrupt priority (must be in range [1..6]) 
    IEC0bits.T3IE = 1; // Enable timer T3 interrupts 
    IFS0bits.T3IF = 0; // Reset timer T3 interrupt flag

    TRISD = (TRISD & 0xFF9F);     // RD5 and RD6 as outputs
    TRISB = (TRISB & 0x80FF);     // RB14 to RB8 as outputs

    EnableInterrupts();

    while(1) {
        int valMedio = 0;

        AD1CON1bits.ASAM = 1;   // start conversion
        while (IFS1bits.AD1IF == 0);        // wait

        int *p = (int*)(&ADC1BUF0);
        for(i = 0; i < 2; i++) {
            valMedio += p[i*4];
        }

        valMedio = valMedio/2;
        voltage = (valMedio*66 + 511)/1023;
        voltage += 7;       // 7 - 73;

        putChar('\r');
        printInt10(voltage);

        IFS1bits.AD1IF = 0;     // reset AD1IF;

        resetCoreTimer();
        while(readCoreTimer() < 4000000);       // 5 Hz
    }
    return 0;
}

void _int_(12) isr_t3(void) {
    send2displays(toBcd(voltage));

    IFS0bits.T3IF = 0;      // reset t3 interrupt flag
}
