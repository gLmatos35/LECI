# include <detpic32.h>

void delay(int ms) {
    resetCoreTimer();
    while(readCoreTimer() < PBCLK/1000 * ms);
}



void send2displays(unsigned char value) {
    unsigned int dl, dh;

    static int display7Scodes[16] = {0x3F, 0x06, 0x5b, 0x4F, 0x66, 0x6D, 0x7D,
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



unsigned char toBcd(unsigned char value) {   
   return ((value / 10) << 4) + (value % 10); 
}



int main(void) {
    TRISD = (TRISD & 0xFF9F);
    TRISB = (TRISB & 0x80FF);

    int i;
    int guwui = 0;
    int value = 0;

    TRISBbits.TRISB4 = 1;       // RBx digital output disconnected 
    AD1PCFGbits.PCFG4= 0;       // RBx configured as analog input 
    AD1CON1bits.SSRC = 7;       // Conversion trigger selection bits: in this 
                                //  mode an internal counter ends sampling and 
                                //  starts conversion 
    AD1CON1bits.CLRASAM = 1;    // Stop conversions when the 1st A/D converter 
                                //  interrupt is generated. At the same time, 
                                //  hardware clears the ASAM bit 
    AD1CON3bits.SAMC = 16;      // Sample time is 16 TAD (TAD = 100 ns) 
    AD1CON2bits.SMPI = 4-1;     // Interrupt is generated after N samples 
                                //  (replace N by the desired number of 
                                //  consecutive samples) 
    AD1CHSbits.CH0SA = 4;       // replace x by the desired input  
                                //  analog channel (0 to 15) 
    AD1CON1bits.ON = 1;         // Enable A/D converter 
                                //  This must the last command of the A/D 
                                //  configuration sequence

    while(1) {
        int valMedio = 0;

        if (guwui%20 == 0) {                       // 0ms, 200ms, 400ms, ..
            AD1CON1bits.ASAM = 1;               // start conversion
            while (IFS1bits.AD1IF == 0);        // wait

            int *p = (int *)(&ADC1BUF0);

            for (i = 0; i < 4; i++) {
                valMedio += p[i*4];
            }

            valMedio /= 4;
            int amp = (valMedio*33 + 511)/1023;
            value = toBcd(amp);

            IFS1bits.AD1IF = 0;
        }

        send2displays(value);

        delay(10);
        guwui++;
    }
    return 0;
}
