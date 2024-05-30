    // config timer
    TxCONbits.TCKPS = n;    // (n = 5 -> 32) 1:32 prescaler (i.e. fout_presc = 625 KHz)
    PRx = 62499;            // Fout = 20MHz / (32 * (62499 + 1)) = 10 Hz 
    TMRx = 0;               // Clear timer T2 count register 
    TxCONbits.TON = 1;      // Enable timer T2 (must be the last command of the 
                            //  timer configuration sequence)
    // config timer for interruptions
    IPC2bits.TxIP = 2; // Interrupt priority (must be in range [1..6]) 
    IEC0bits.TxIE = 1; // Enable timer T2 interrupts 
    IFS0bits.TxIF = 0; // Reset timer T2 interrupt flag