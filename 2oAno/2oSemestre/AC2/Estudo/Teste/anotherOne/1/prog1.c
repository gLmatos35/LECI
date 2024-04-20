# include <detpic32.h>

int main(void) {
    TRISE = (TRISE & 0xFFC3);       // output;

    TRISB = (TRISB | 0x0004);       // input
    int counter = 0;

    while(1) {
        unsigned int switch2 = PORTBbits.RB2;

        LATE = (LATE & 0xFFC3) | counter << 2;

        if (switch2 == 0) {
            counter = (counter + 11) % 12;
            resetCoreTimer();
            while(readCoreTimer() < 8695652);
        } else {
            counter = (counter + 11) % 12;
            resetCoreTimer();
            while(readCoreTimer() < 3636363);
        }

        printInt(counter, 10 | 2 << 16);
        putChar('\n');
    }
}
