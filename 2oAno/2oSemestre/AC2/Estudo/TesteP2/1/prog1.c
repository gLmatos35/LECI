# include <detpic32.h>

void delay(unsigned int ms) {
    resetCoreTimer();
    while(readCoreTimer() < PBCLOCK/1000 * ms)
}

int main(void) {
    static char flag = 0;

    T3CONbits.TCKPS = 2; // 1:4 prescaler 
    PR3 = 38461;   // 38460,5 -> 130Hz
    TMR3 = 0;    // Reset timer 3 count register 
    T3CONbits.TON = 1; // Enable timer T3 

    OC4CONbits.OCM = 6;  // PWM mode on OCx; fault pin disabled 
    OC4CONbits.OCTSEL = 1;// Use timer T3 as the time base for PWM generation 
    OC4RS = 19231;   // Ton constant = 19230,5
    OC4CONbits.ON = 1; // Enable OC4 module 

    TRISBbits.TRISB1 = 1;       // input

    while(1) {
                                    // duty-cycle varia entre 25% e 75% a cada 1.3s
    if (PORTBbits.PORTB1 == 0) {    // utilizar o coreTimer
        delay(1300);
        if (flag == 0) {
            OC4RS = 9616;   // Ton constant = 9615,25 (25%)
        } else {
            OC4RS = 28846;      // Ton constant = 28845,75 (75%)
        }
    }
    flag = !flag;
    }
    return 0;
}