// k = f_PBCLK/(f_out * (PRx + 1))
// k = (20 * 10⁶6)/(2 * (2^16 + 1)) = 152.68 -> 256 (seguinte)

// PRx = (f_PBCLK / (f_out * K)) - 1  = (20 * 10^6)/(2 * 256) - 1 = 39061,5

# include <detpic32.h>

int main(void) {
    // config timer
    T3CONbits.TCKPS = 7;    // (n = 5 -> 32) 1:32 prescaler (i.e. fout_presc = 625 KHz)
    PR3 = 39062;            // Fout = 20MHz / (32 * (62499 + 1)) = 10 Hz 
    TMR3 = 0;               // Clear timer T2 count register 
    T3CONbits.TON = 1;      // Enable timer T2 (must be the last command of the 
                            //  timer configuration sequence)

    while(1) {
        while(IFS0bits.T3IF == 0);
        IFS0bits.T3IF = 0;

        putChar('.');
    }
    return 0;
}
