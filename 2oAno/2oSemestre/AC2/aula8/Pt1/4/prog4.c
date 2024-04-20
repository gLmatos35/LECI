# include <detpic32.h>

int main(void) {
    // Timer 1 => 5Hz
    T1CONbits.TCKPS = 2;
    PR1 = 62499;
    TMR1 = 0;
    T1CONbits.TON = 1;

    // Timer 3 => 25Hz
    T3CONbits.TCKPS = 4;
    PR3 = 49999;
    TMR3 = 0;
    T3CONbits.TON = 1;  

    // config Timer 1 for interruptions
    IPC1bits.T1IP = 2; // Interrupt priority (must be in range [1..6]) 
    IEC0bits.T1IE = 1; // Enable timer T2 interrupts 
    IFS0bits.T1IF = 0; // Reset timer T2 interrupt flag

    // config Timer 3 for interruptions
    IPC3bits.T3IP = 2; // Interrupt priority (must be in range [1..6]) 
    IEC0bits.T3IE = 1; // Enable timer T2 interrupts 
    IFS0bits.T3IF = 0; // Reset timer T2 interrupt flag

    EnableInterrupts();         // global interrupt enable

    while(1);
    return 0;
}


void _int_(4) isr_t1(void) {
    putChar('1');
    IFS0bits.T1IF = 0;      // reset T1IF
}

void _int_(12) isr_t3(void) { 
   // print character '3'
   putChar('3');
   // Reset T3IF flag
   IFS0bits.T3IF = 0;
}
