# include <detpic32.h>

void delay(unsigned int ms)
{
    resetCoreTimer();
    while(readCoreTimer() < PBCLK/1000 * ms);        // PBCLK = 20.000.000
}

// includes freq of 40MHz
// defines peripheral bus clock to freq/2

int main(void)
{
    // Configure port RC14 as output
    TRISCbits.TRISC14 = 0;
    while(1)
    {
        // Wait 0.5s
        delay(500);
        // Toggle RC14 port value
        LATCbits.LATC14 = !LATCbits.LATC14;
    }
    return 0;
}