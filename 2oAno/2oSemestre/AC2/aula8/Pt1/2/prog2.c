# include <detpic32.h>

int main(void) { 
    // Configure Timer T3 with interrupts enabled
    T3CONbits.TCKPS = 7;    // 1:256 prescaler (i.e. fout_presc = 625 KHz) 
    PR3 = 39062;            // Fout = 20MHz / (256 * (62499 + 1)) = 2 Hz 
    TMR3 = 0;               // Clear timer T3 count register 
    T3CONbits.TON = 1;      // Enable timer T3 (must be the last command of the 
                            //  timer configuration sequence)
    IPC3bits.T3IP = 2; // Interrupt priority (must be in range [1..6]) 
    IEC0bits.T3IE = 1; // Enable timer T3 interrupts 
    IFS0bits.T3IF = 0; // Reset timer T3 interrupt flag

    EnableInterrupts(); 
    while(1); 
    return 0; 
} 
    
void _int_(12) isr_t3(void) {           // Replace VECTOR by the timer T3  
                                        //  vector number 
    putChar('.'); 
    // Reset T3 interrupt flag 
    IFS0bits.T3IF = 0;
}
