# include <detpic32.h>

volatile unsigned int voltage;         // global volatile


void delay(int ms) {
    resetCoreTimer();
    while(readCoreTimer() < PBCLK/1000 * ms);
}



void send2displays(unsigned char value) {
    unsigned int dl, dh;

    static int display7Scodes[16] = {0x3F, 0x06, 0x5b, 0x4F, 0x66, 0x6D, 0x7D,
0x07, 0x7F, 0x6F, 0x77,0x7C,0x39, 0x5E,0x79,0x71};  
    
    static char displayFlag = 0;
    dl = value & 0x0F;
    dh = value >> 4;

    if(displayFlag == 0) {
        LATD = (LATD & 0xFF9F) | 0x0020;        // select lower display
        LATB = (LATB & 0x80FF) | (display7Scodes[dl] << 8);
    } else {
        LATD = (LATD & 0xFF9F) | 0x0040;
        LATB = (LATB & 0x80FF) | (display7Scodes[dh] << 8);
    }

    displayFlag = !displayFlag;
}



unsigned char toBcd(unsigned char value) {   
   return ((value / 10) << 4) + (value % 10); 
}



int main(void) {
    TRISD = (TRISD & 0xFF9F);
    TRISB = (TRISB & 0x80FF);

    // int voltage = 0;

    TRISBbits.TRISB4 = 1;       // RBx digital output disconnected 
    AD1PCFGbits.PCFG4= 0;       // RBx configured as analog input 
    AD1CON1bits.SSRC = 7;       // Conversion trigger selection bits: in this 
                                //  mode an internal counter ends sampling and 
                                //  starts conversion 
    AD1CON1bits.CLRASAM = 1;    // Stop conversions when the 1st A/D converter 
                                //  interrupt is generated. At the same time, 
                                //  hardware clears the ASAM bit 
    AD1CON3bits.SAMC = 16;      // Sample time is 16 TAD (TAD = 100 ns) 
    AD1CON2bits.SMPI = 8-1;     // Interrupt is generated after N samples 
                                //  (replace N by the desired number of 
                                //  consecutive samples) 
    AD1CHSbits.CH0SA = 4;       // replace x by the desired input  
                                //  analog channel (0 to 15) 
    AD1CON1bits.ON = 1;         // Enable A/D converter 
                                //  This must the last command of the A/D 
                                //  configuration sequence

    // config adc for interruptions
    IPC6bits.AD1IP = 2;  // configure priority of A/D interrupts
    IFS1bits.AD1IF = 0;  // clear A/D interrupt flag
    IEC1bits.AD1IE = 1;  // enable A/D interrupts

    // T1 -> 5Hz (200ms)
    T1CONbits.TCKPS = 2; // 1:64 prescaler (i.e Fout_presc = 625 KHz) 
    PR1 = 62499;   // Fout = 20MHz / (32 * (62499 + 1)) = 10 Hz 
    TMR1 = 0;    // Reset timer T2 count register 
    T1CONbits.TON = 1; // Enable timer T2 (must be the last command of the 
            //  timer configuration sequence) 

    // config Timer 1 for interruptions
    IPC1bits.T1IP = 2; // Interrupt priority (must be in range [1..6]) 
    IEC0bits.T1IE = 1; // Enable timer T2 interrupts 
    IFS0bits.T1IF = 0; // Reset timer T2 interrupt flag
    

    // T3 -> 100 Hz (10ms)
        // T1 -> 5Hz (200ms)
    T3CONbits.TCKPS = 2; // 1:4 prescaler (i.e Fout_presc = 625 KHz) 
    PR3 = 49999;   // Fout = 20MHz / (32 * (62499 + 1)) = 10 Hz 
    TMR3 = 0;    // Reset timer T2 count register 
    T3CONbits.TON = 1; // Enable timer T2 (must be the last command of the 
            //  timer configuration sequence) 

    // config Timer 3 for interruptions
    IPC3bits.T3IP = 2; // Interrupt priority (must be in range [1..6]) 
    IEC0bits.T3IE = 1; // Enable timer T3 interrupts 
    IFS0bits.T3IF = 0; // Reset timer T3 interrupt flag

    // configureAll(); ^ é o que está acima 

    IFS1bits.AD1IF = 0;     // reset AD1IF flag
    // reset das flags dos timer está em cima

    EnableInterrupts();             // global interrupt enable
    while(1);

    return 0;
}


void _int_ (4) isr_t1(void) {
    AD1CON1bits.ASAM = 1;           // start A/D conversion
    IFS0bits.T1IF = 0;              // Reset timer T1 interrupt flag
}



void _int_ (12) isr_t3(void) {
    send2displays(voltage);  // send Bcd(voltage) to displays
    IFS0bits.T3IF = 0;              // Reset timer T3 interrupt flag
}


    
void _int_ (27) isr_adc(void) {     
    int VAL_AD = 0, V; 
    // ISR actions
    int *p = (int *)(&ADC1BUF0);


    for(; p <= (int *)(&ADC1BUFF); p+=4) {      // lê se do BUF0 até ao BUFF (15) porque 
                                // por muito que so queira ler até ao BUF7 (inclusive), 
                                // qualquer buffer nao lido ter o valor 0, e portanto
                                // vai funcionar de qualquer forma
                                // em alternativa, usar a maneira anterior para isto
        VAL_AD += *p;
    }

    VAL_AD = VAL_AD / 8;

    // calculate voltage amplitude
    V = (VAL_AD*33 + 511)/1023;
    VAL_AD = 0;
    // convert voltage amplitude to decimal
    voltage = toBcd(V);
    IFS1bits.AD1IF = 0;
}
