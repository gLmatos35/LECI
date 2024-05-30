// k = f_PBCLK/(f_out * (PRx + 1))
// k = (20 * 10⁶6)/(2 * (2^16 + 1)) = 152.68 -> 256 (seguinte)

// PRx = (f_PBCLK / (f_out * K)) - 1  = (20 * 10^6)/(2 * 256) - 1 = 39061,5

# include <detpic32.h>

int main(void) {
    // config timer - f = 10 Hz -> T = 100ms
    T2CONbits.TCKPS = 5;    // (n = 5 -> 32) 1:32 prescaler (i.e. fout_presc = 625 KHz)
    PR2 = 62499;            // Fout = 20MHz / (32 * (62499 + 1)) = 10 Hz 
    TMR2 = 0;               // Clear timer T2 count register 
    T2CONbits.TON = 1;      // Enable timer T2 (must be the last command of the 
                            //  timer configuration sequence)
    // config timer for interruptions
    IPC2bits.T2IP = 2; // Interrupt priority (must be in range [1..6]) 
    IEC0bits.T2IE = 1; // Enable timer T2 interrupts 
    IFS0bits.T2IF = 0; // Reset timer T2 interrupt flag

    IPC1bits.INT1IP = 2;
    IEC0bits.INT1IE = 1;
    IFS0bits.INT1IF = 0;

    TRISDbits.TRISD8 = 1;

    TRISEbits.TRISE0 = 0;   // config como saída
    LATEbits.LATE0 = 0;     // led desligado

    EnableInterrupts();
    while(1);
    return 0;
}

void _int_(8) isr_t2(void) {
    static int counter = 0;
    if (counter%30 == 0) {
        counter = 0;
        LATEbits.LATE0 = 0;
        T2CONbits.TON = 0;      // disable timer
    }
    counter++;
    IFS0bits.T2IF = 0;      // reset t2 interrupt flag;
}

void _int_(7) isr_int1(void) {
    LATEbits.LATE0 = 1;     // turn led on
    T2CONbits.TON = 1;      // enable timer
    IFS0bits.INT1IF = 0;    // reset int1 interrupt flag
}
