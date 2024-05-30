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
    // config timer for interruptions
    IPC3bits.T3IP = 2; // Interrupt priority (must be in range [1..6]) 
    IEC0bits.T3IE = 1; // Enable timer T2 interrupts 
    IFS0bits.T3IF = 0; // Reset timer T2 interrupt flag

    EnableInterrupts();
    while(1);
    return 0;
}


void _int_(12) isr_t3(void) {
    putChar('a');
    IFS0bits.T3IF = 0;      // reset t3 interrupt flag
}
