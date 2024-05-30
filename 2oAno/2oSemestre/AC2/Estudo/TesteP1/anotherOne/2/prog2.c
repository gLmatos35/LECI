# include <detpic32.h>


void send2displays(unsigned char value) {
    static int display7Scodes[16] = {0x3F, 0x06, 0x5b, 0x4F, 0x66, 0x6D, 0x7D,
0x07, 0x7F, 0x6F, 0x77,0x7C,0x39, 0x5E,0x79,0x71};  

    LATD = (LATD & 0xFFDF) | 0x0020;        // select lower display

    LATB = (LATB & 0x80FF) | (display7Scodes[value] << 8);
}

int main(void) {
    TRISBbits.TRISB4 = 1;           // RBx digital output disconnected 
    AD1PCFGbits.PCFG4= 0;           // RBx configured as analog input 
    AD1CON1bits.SSRC = 7;           // Conversion trigger selection bits: in this 
                                    //  mode an internal counter ends sampling and 
                                    //  starts conversion 
    AD1CON1bits.CLRASAM = 1;        // Stop conversions when the 1st A/D converter 
                                    //  interrupt is generated. At the same time, 
                                    //  hardware clears the ASAM bit 
    AD1CON3bits.SAMC = 16;          // Sample time is 16 TAD (TAD = 100 ns) 
    AD1CON2bits.SMPI = 2-1;         // Interrupt is generated after N samples 
                                    //  (replace N by the desired number of 
                                    //  consecutive samples) 
    AD1CHSbits.CH0SA = 4;           // replace x by the desired input  
                                    //  analog channel (0 to 15) 
    AD1CON1bits.ON = 1;             // Enable A/D converter 
                                    //  This must the last command of the A/D 
                                    //  configuration sequence

//////////////////////////// ex >

    TRISD = (TRISD & 0xFFDF);       // select lower display as output
    TRISB = (TRISB & 0x80FF);       // segments as outputs
    TRISEbits.TRISE1 = 0;           // output

    int i;

    while(1) {
        int valMedio = 0;
        
        resetCoreTimer();
        while(readCoreTimer() < 3333333);       // 6 hz

        AD1CON1bits.ASAM = 1;       // start conversion

        while (IFS1bits.AD1IF == 0);        // wait

        LATEbits.LATE1 = !LATEbits.LATE1;

        int *p = (int *) (&ADC1BUF0);

        for (i = 0; i < 2; i++) {
            valMedio += p[i*4];
        }

        valMedio /= 2;              // valMedio/2
        printInt(valMedio, 16 | 3 << 16);
        putChar('\n');

        int value = (valMedio*9 + 511)/1023;
        send2displays(value); 

        IFS1bits.AD1IF = 0;
    }

    return 0;
}
