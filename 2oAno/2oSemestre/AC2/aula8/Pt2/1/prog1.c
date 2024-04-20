# include <detpic32.h>

void delay(unsigned int ms) {
    resetCoreTimer();
    while(readCoreTimer() < PBCLK/1000 * ms);
}

int main(void) {
    TRISDbits.TRISD8 = 1;       // input
    TRISEbits.TRISE0 = 0;       // output

    LATEbits.LATE0 = 0;

    while(1) {
        // LATEbits.LATE0 = 0;
        while(PORTDbits.RD8 == 1);
        LATEbits.LATE0 = 1;
        delay(3000);
        LATEbits.LATE0 = 0;
    }
}
