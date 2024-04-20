# include <detpic32.h>

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

    if (displayFlag == 0){ 
        LATD = (LATD & 0xFF9F) | 0x0020;        // select lower display
        LATB = (LATB & 0x80FF) | (display7Scodes[dl] << 8); // send value to lower display  
    } else {
        LATD = (LATD & 0xFF9F) | 0x0040;        // select higher display
        LATB = (LATB & 0x80FF) | (display7Scodes[dh] << 8); // send value to lower display  
    }

    displayFlag = !displayFlag;
}

int main(void) {
    unsigned int i, counter;

    i = 0;
    counter = 0;

    TRISD = (TRISD & 0xFF9F);           // d6 and d5 as outputs;

    TRISB = (TRISB & 0x80FF);           // b8 to b14 as outputs;

    while(1) {
        delay(5);                       // valor correto seria 10 mas sou esquizo

        send2displays(counter);

        if (i % 20 == 0) {
            counter++;
        }
        i++;
        counter = counter % 256;
    }
    return 0;
}
