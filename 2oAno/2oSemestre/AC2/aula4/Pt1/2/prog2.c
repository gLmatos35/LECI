# include <detpic32.h>

// includes freq of 40MHz
// defines peripheral bus clock to freq/2

int main(void)
{
    //  Re7 Re6 Re5 Re4 Re3 Re2 Re1 Re0
    //  1   0   0   0   0   1   1   1       Re6 - Re3 como saidas
    TRISE = TRISE & 0xFF87;

    int counter = 0;

    while(1) {
        LATE = (LATE & 0xFF87) | counter << 3;
        // f = 4.6Hz
        // T = 1/4.6 = 0.217391
        // 1s       -------- PBCLK (20000000)
        // 0.217391 -------- x
        // x = 4347826
        resetCoreTimer(); while( readCoreTimer() < 4347826 );

        //counter = (counter + 1) % 10;           // crescente
        counter = (counter + 9) % 10;           // decrescente
    }
    return 0;
}