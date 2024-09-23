# include <detpic32.h>

void delay(unsigned int ms) {
    resetCoreTimer();
    while(readCoreTimer() < PBCLK/1000 * ms);
}

int main(void) {

    T3CONbits.TCKPS = 2;        // 1:4 prescaler (i.e Fout_presc = 625 KHz)
    PR3 = 38461;                // Fout = 20MHz / (32 * (62499 + 1)) = 10 Hz
    TMR3 = 0;                   // Reset timer T2 count register
    T3CONbits.TON = 1;          // Enable timer T2 (must be the last command of the
                                // timer configuration sequence)
    OC4CONbits.OCM = 6;         // PWM mode on OCx; fault pin disabled
    OC4CONbits.OCTSEL = 1;      // Use timer T3 as the time base for PWM generation
    OC4RS = 19231;              // 50% - default
    OC4CONbits.ON = 1;          // Enable OC1 module

    TRISBbits.TRISB1 = 1;       // input

    while(1) {
        static unsigned char flag = 0;
        if(PORTBbits.RB1 == 1) {
            if(flag == 0) {
                OC4RS = 9616;
            } else {
                OC4RS = 28846;
            }
            delay(1300);
        }
    }
    return 0;
}
