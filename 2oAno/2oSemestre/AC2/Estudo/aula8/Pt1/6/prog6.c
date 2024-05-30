// k = f_PBCLK/(f_out * (PRx + 1))
// k = (20 * 10⁶6)/(2 * (2^16 + 1)) = 152.68 -> 256 (seguinte)

// PRx = (f_PBCLK / (f_out * K)) - 1  = (20 * 10^6)/(2 * 256) - 1 = 39061,5

# include <detpic32.h>

int main(void) {
    // config timer 1
    // 1 8 64 256
    T1CONbits.TCKPS = 2;    // (n = 5 -> 32) 1:32 prescaler (i.e. fout_presc = 625 KHz)
    PR1 = 62499;            // Fout = 20MHz / (32 * (62499 + 1)) = 10 Hz 
    TMR1 = 0;               // Clear timer T2 count register 
    T1CONbits.TON = 1;      // Enable timer T2 (must be the last command of the 
                            //  timer configuration sequence)
    // config timer 1 for interruptions
    IPC1bits.T1IP = 2; // Interrupt priority (must be in range [1..6]) 
    IEC0bits.T1IE = 1; // Enable timer T2 interrupts 
    IFS0bits.T1IF = 0; // Reset timer T2 interrupt flag

    // config timer 3 (mudei para 10Hz)
    // 1 2 4 8 16 32 64 256
    T3CONbits.TCKPS = 5;    // (n = 5 -> 32) 1:32 prescaler (i.e. fout_presc = 625 KHz)
    PR3 = 62499;            // Fout = 20MHz / (32 * (62499 + 1)) = 10 Hz 
    TMR3 = 0;               // Clear timer T2 count register 
    T3CONbits.TON = 1;      // Enable timer T2 (must be the last command of the 
                            //  timer configuration sequence)
    // config timer 3 for interruptions
    IPC3bits.T3IP = 2; // Interrupt priority (must be in range [1..6]) 
    IEC0bits.T3IE = 1; // Enable timer T2 interrupts 
    IFS0bits.T3IF = 0; // Reset timer T2 interrupt flag    

    EnableInterrupts();

    // 1111 1111 1111 0101
    TRISE = TRISE & 0xFFF5;
    // 1111 1111 1111 0101
    LATE = (LATE & 0xFFF5);

    while(1);
    return 0;
}

void _int_(4) isr_t1(void) {
    putChar('1');
    LATEbits.LATE1 = !LATEbits.LATE1;
    IFS0bits.T1IF = 0;
}

void _int_(12) isr_t3(void) {
    putChar('3');
    LATEbits.LATE3 = !LATEbits.LATE3;
    IFS0bits.T3IF = 0;
}
