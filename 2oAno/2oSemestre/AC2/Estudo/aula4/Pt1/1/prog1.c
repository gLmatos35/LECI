# include <detpic32.h>

void delay(unsigned int ms)
{
    resetCoreTimer();
    while(readCoreTimer() < PBCLK/1000 * ms);
}

int main (void) {
    TRISCbits.TRISC14 = 0;      // config RC14 as output
    
    while(1) {
        delay(500);             // wait 0.5s

        LATCbits.LATC14 = !LATCbits.LATC14;
    }
    return 0;
}
