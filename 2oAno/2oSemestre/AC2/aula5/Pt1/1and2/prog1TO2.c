# include <detpic32.h>

void delay(unsigned int ms)
{
    resetCoreTimer();
    while(readCoreTimer() < PBCLK/1000 * ms);
}

void send2displays(unsigned char value)
{
    static const char display7Scodes[] = {0x3F, 0x06, 0x5b, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F, 0x77,0x7C,0x39, 0x5E,0x79,0x71};
    
    unsigned int dh,dl;
    // select display high
    LATD = (LATD & 0xFF9F) | 0x0040;    // bit6 (high)
    // send digit_high (dh) to display:
    dh = value >> 4;
    LATB = (LATB & 0x80FF) | (display7Scodes[dh] << 8);
    
    // select display low
    LATD = (LATD & 0xFF9F) | 0x0020;    // bit5 (low)
    // send digit_low (dl) to display:
    dl = value & 0x0F;
    LATB = (LATB & 0x80FF) | (display7Scodes[dl] << 8);
}

int main(void)
    {
    // configure ports RB8 to RB14 as outputs
    TRISB = TRISB & 0x80FF;     // 1000 0000 1111 1111  (?)
    // configure RD5-RD6 as outputs
    TRISD = TRISD & 0xFF9F;     // 1111 1111 1001 1111
    // main loop
    while(1)
    {
    send2displays(0x15);
    // wait 0.2s
    delay(200);
    }
    return 0;
}