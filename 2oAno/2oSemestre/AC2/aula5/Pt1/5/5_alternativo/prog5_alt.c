# include <detpic32.h>

void delay(unsigned int ms)
{
    resetCoreTimer();
    while(readCoreTimer() < PBCLK/1000 * ms);
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

int main(void)
    {
    // freq de contagem = 5Hz   -   Tc = 200 ms
    // freq de refresh = 100Hz   -   Tr = 10 ms    <-- como é a maior freq, é a que vai (..)


    unsigned int counter, i;
    // configure ports RB8 to RB14 as outputs
    TRISB = TRISB & 0x80FF;     // 1000 0000 1111 1111  (?)
    // configure RD5-RD6 as outputs
    TRISD = TRISD & 0xFF9F;     // 1111 1111 1001 1111

    counter = 0;
    i = 0;
    // main loop
    while(1) {
        delay(10);       //  10 é mult comum de 200 e 10

        send2displays(counter);
        
        if (i % 20 == 0) {
            counter = (counter + 1) % 256;      // % 256 porque é modulo 256
        }
        i++;
    }
    return 0;
}