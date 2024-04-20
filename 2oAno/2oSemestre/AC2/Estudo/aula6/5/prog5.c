# include <detpic32.h>

int main(void) {
    int i = 0;

    

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
        AD1CON1bits.ASAM = 1;   // start conversion

        while (IFS1bits.AD1IF == 0);        // wait while conversion isnt done

        int valMedio = 0;

        putChar('\r');
        // printInt(ADC1BUF0, 16 | 3 << 16);
        int *p = (int *)(&ADC1BUF0);

        for (i = 0; i < 4; i++) {
            valMedio += p[i*4];
            
            printInt(p[i*4], 10 | 4 << 16);
            putChar('\t');
        }

        valMedio = valMedio/4;
        printInt(valMedio, 16 | 4 << 16);

        putChar('\t');
        // V = (VAL_AD*33+511)/1023 
        int amp = (valMedio * 33 + 511)/1023;
        printInt(amp, 10 | 2 << 16);

        IFS1bits.AD1IF = 0;     // reset AD1IF;
    }

    return 0;
}
