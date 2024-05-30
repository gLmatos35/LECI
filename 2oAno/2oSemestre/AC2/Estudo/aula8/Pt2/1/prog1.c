# include <detpic32.h>

void delay(unsigned int ms) {
    resetCoreTimer();
    while(readCoreTimer() < PBCLK/1000 * ms);
}

int main(void) {
    TRISDbits.TRISD8 = 1;   // config como entrada

    TRISEbits.TRISE0 = 0;   // config como saída
    LATEbits.LATE0 = 0;     // led desligado

    int toggle = 0;

    while(1) {
        while (PORTDbits.RD8 == 0) {
            toggle = 1; 
            LATEbits.LATE0 = 1;
        }

        if (toggle == 1) {
            LATEbits.LATE0 = 1;
            delay(3000);
            LATEbits.LATE0 = 0;
            toggle = 0;
        }
    }
    return 0;
}
