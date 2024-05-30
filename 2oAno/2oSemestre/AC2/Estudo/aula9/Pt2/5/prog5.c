# include <detpic32.h>

void setPWM(unsigned int dutyCycle) {
    OC1RS = ((PR3 + 1) * dutyCycle) / 100;
}

int main(void) {

    TRISCbits.TRISC14 = 0;      // saida

    T3CONbits.TCKPS = 2; // 1:4 prescaler (i.e Fout_presc = 625 KHz) 
    PR3 = 49999;   // Fout = 20MHz / (32 * (62499 + 1)) = 10 Hz 
    TMR3 = 0;    // Reset timer T2 count register 
    T3CONbits.TON = 1; // Enable timer T2 (must be the last command of the 
                    // timer configuration sequence) 
    OC1CONbits.OCM = 6;  // PWM mode on OCx; fault pin disabled 
    OC1CONbits.OCTSEL = 1;// Use timer T2 as the time base for PWM generation 

    unsigned int dutyC;

    printStr("Introduz o duty cycle pretendido - (0 a 100)");
    putChar('\n');
    printStr(">> ");
    dutyC = readInt10();
    setPWM(dutyC);   // Ton constant - define o duty cycle
    OC1CONbits.ON = 1; // Enable OC1 module 

    while(1) {
        LATCbits.LATC14 = PORTDbits.RD0;    
    }
    return 0;
}
