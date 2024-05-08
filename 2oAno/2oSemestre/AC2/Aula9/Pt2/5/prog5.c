# include <detpic32.h>

void setPWM(unsigned int dutyCycle) {
    // duty_cycle must be in the range [0, 100]
    OC1RS = ((PR3+1) * dutyCycle)/100 ; // Determine OC1RS as a function of "dutyCycle" 
} 



int main(void) {

    // TRISD = (TRISD & 0xFFFE);     // RD0 as output - OC1
    // não é necessario porque a ativaçao do output compare module OCx o configura automaticamente
    // como saida, sobrepondo se à configuraçao efetuada pelo TRISD
 
    // 1011 1111 1111 1111
    TRISC = (TRISC & 0xBFFF);       // RC14 as output

    // T3 -> 100Hz
    T3CONbits.TCKPS = 2; // 1:4 prescaler (i.e Fout_presc = 625 KHz) 
    PR3 = 49999;   // Fout = 20MHz / (32 * (62499 + 1)) = 10 Hz 
    TMR3 = 0;    // Reset timer T2 count register 
    T3CONbits.TON = 1; // Enable timer T2 (must be the last command of the 
                    //  timer configuration sequence) 
    OC1CONbits.OCM = 6;  // PWM mode on OCx; fault pin disabled 
    OC1CONbits.OCTSEL = 1;// Use timer T3 as the time base for PWM generation 
    // OC1RS = 12500;   // Ton constant (25% dos 50000 do PR3)
    printStr("Insere um valor de duty cycle entre 0 e 100 (%)");

    putChar('\n');
    printStr(">> ");
    unsigned int dutyC = readInt10();

    setPWM(dutyC);
    OC1CONbits.ON = 1; // Enable OC1 module

    // resolução:
    // log2(5000000/100) = 15.6096404744 (bits)

    while(1) {
        LATCbits.LATC14 = PORTDbits.RC14;       // RC14 errado
    }


    return 0;
}

// nota: caso no osciloscopio aquilo esteja todo tweaking, provavelmente é o trigger
// colocar o mf no meio da amplitude (é a ceninha amarela TL do lado direito no ecra )
