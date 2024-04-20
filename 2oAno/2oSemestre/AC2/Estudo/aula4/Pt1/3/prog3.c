# include <detpic32.h>

int main(void) {
    TRISE = TRISE & 0xFF87;

    int counter = 0;

    while(1) {
        LATE = (LATE & 0xFF87) | counter << 3;

        resetCoreTimer();
        while(readCoreTimer() < PBCLK/2.7);

        counter = counter > 0 ? counter - 1 : 9;
    }
    return 0;       
}
