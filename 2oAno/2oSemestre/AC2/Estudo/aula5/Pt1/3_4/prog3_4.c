# include <detpic32.h>

void send2displays(unsigned char value) {
    unsigned int dl,dh;

    static int display7Scodes[16] = {0x3F, 0x06, 0x5b, 0x4F, 0x66, 0x6D, 0x7D,
0x07, 0x7F, 0x6F, 0x77,0x7C,0x39, 0x5E,0x79,0x71};

    static char displayFlag = 0;

    dl = value & 0x0F;
    dh = value >> 4;

    if (displayFlag == 0) {
        LATD = (LATD & 0xFF9F) | 0x0020;        // select display lower

        LATB = (LATB & 0x80FF) | display7Scodes[dl] << 8;       // send to lower display
    } else {
        LATD = (LATD & 0xFF9F) | 0x0040;        // select display high

        LATB = (LATB & 0x80FF) | display7Scodes[dh] << 8;
    }
    displayFlag = !displayFlag;
}



int main(void) {
    TRISB = TRISB & 0x80FF;         // RB8 - RB14 as outputs
    // 1000 0000 1111 1111
    TRISD = TRISD & 0xFF9F;          // select displays as outputs;
    
    while(1) {
        send2displays(0x15);

        resetCoreTimer();
        while(readCoreTimer() < PBCLK/100);       // (wait 0.2s)
    }
    return 0;
}
