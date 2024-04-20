# include <detpic32.h>

volatile unsigned char voltage = 0; // Global variable
// volatile quando temos uma variavel q tem que usar sempre o valor mais recente
// caso o sistema esteja a trabalhar em modo otimizado poderia usar um valor cache,
// ou seja, um valor que poderia nao ser o atual

void delay(unsigned int ms)
{
    resetCoreTimer();
    while(readCoreTimer() < PBCLK/1000 * ms);
}




unsigned char toBcd(unsigned char value)
{
    return ((value / 10) << 4) + (value % 10);
}





void send2displays(unsigned char value)
{
    static const char display7Scodes[] = {0x3F, 0x06, 0x5b, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F, 0x77,0x7C,0x39, 0x5E,0x79,0x71};
    
    unsigned int digit_high, digit_low;

    static char displayFlag = 0;        // static variable: doesn't lose its value between calls to function
    
    digit_low = value & 0x0F;

    digit_high = value >> 4;

    // if displayFlag == 0, then send digit low to display low
    if (!displayFlag) {
        putChar('x');
        // select display low
        LATD = (LATD & 0xFF9F) | 0x0020;    // bit5
        // send digit low to display
        LATB = (LATB & 0x80FF) | (display7Scodes[digit_low] << 8);
    }
    else {              // else send digit high to display high
        putChar('y');
        //select display high
        LATD = (LATD & 0xFF9F) | 0x0040;    // bit6 (high)
        // send digit high to display
        LATB = (LATB & 0x80FF) | (display7Scodes[digit_high] << 8);
    }
    
    displayFlag = !displayFlag;
}




int main (void) {

    unsigned int cnt = 0;

    // configure ports RB8 to RB14 as outputs
    TRISB = TRISB & 0x80FF;     // 1000 0000 1111 1111
    // configure RD5-RD6 as outputs
    TRISD = TRISD & 0xFF9F;     // 1111 1111 1001 1111

    TRISBbits.TRISB4 = 1;
    AD1PCFGbits.PCFG4= 0;
    AD1CON1bits.SSRC = 7;
    // RBx digital output disconnected
    // RBx configured as analog input
    // Conversion trigger selection bits: in this
    // mode an internal counter ends sampling and
    // starts conversion
    AD1CON1bits.CLRASAM = 1; // Stop conversions when the 1st A/D converter
    // interrupt is generated. At the same time,
    // hardware clears the ASAM bit
    AD1CON3bits.SAMC = 16;
    // Sample time is 16 TAD (TAD = 100 ns)
    AD1CON2bits.SMPI = 8-1; // Interrupt is generated after N samples
    // (replace N by the desired number of
    // consecutive samples)
    AD1CHSbits.CH0SA = 4;
    // replace x by the desired input
    // analog channel (0 to 15)
    AD1CON1bits.ON = 1;
    // Enable A/D converter
    // This must the last command of the A/D
    // configuration sequence
    
    // Configure interrupt system
    IPC6bits.AD1IP = 2; // configure priority of A/D interrupts
    
    IFS1bits.AD1IF = 0; // clear A/D interrupt flag

    IEC1bits.AD1IE = 1; // enable A/D interrupts

    EnableInterrupts(); // Global Interrupt Enable

    // Start A/D conversion

    while(1) {
        if(cnt == 0) // 0, 200 ms, 400 ms, ... (5 samples/second)
        {
            // Start A/D conversion
            AD1CON1bits.ASAM = 1;
        }

        // Send "voltage" value to displays
        send2displays(toBcd(voltage));

        cnt = (cnt + 1) % 20;       // 200 / 10 = 20        f = 5Hz -> T = 200ms
        // Wait ?? ms (?? = refresh rate mais baixo = 10 ms)
        delay(10);
    }
return 0;
}





void _int_(27) isr_adc(void)
{
    // Read 8 samples (ADC1BUF0, ..., ADC1BUF7) and calculate average
    // Calculate voltage amplitude
    int *p = (int*)(&ADC1BUF0), VAL_AD = 0;
    for (; p <= (int*)(&ADC1BUFF); p+=4) {
        VAL_AD += *p;
    }

    VAL_AD = VAL_AD/8;
    voltage = (VAL_AD*33+511) / 1023;
    // Convert voltage amplitude to decimal and store the result in the global variable "voltage"
    // Reset AD1IF flag
    IFS1bits.AD1IF = 0;
}