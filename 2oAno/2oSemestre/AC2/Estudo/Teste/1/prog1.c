# include <detpic32.h>

int main(void) {
    TRISE = (TRISE & 0xFFC3);       // RE5 to RE2 as outputs
    // 1111 1111 1100 0011
    TRISB = (TRISB | 0x0004);        // RB2 as input

    int counter = 0;

    while(1) {

        LATE = (LATE & 0xFFC3) | counter << 2;

        if (PORTBbits.RB2 == 0) {
            counter = (counter + 11) % 12;
            resetCoreTimer();
            while(readCoreTimer() < 8695652);
        }

        if (PORTBbits.RB2 == 1) {
            counter = (counter + 11) % 12;
            resetCoreTimer();
            while(readCoreTimer() < 3636363);
        }

        printInt(counter, 10 | 2 << 16);
        putChar('\n');
    }

    return 0;
}
