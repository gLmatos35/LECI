#include <detpic32.h>

int main(void) {
    TRISB = TRISB & 0x80FF;         // RB8 - RB14 as outputs;
    // 1000 0000 1111 1111

    // TRISDbits.TRISD5 = 0;
    // TRISDbits.TRISd6 = 0;
    TRISD = TRISD & 0xFF9F;
    // 1111 1111 1001 1111

    LATDbits.LATD5 = 1;             // activate right side display;
    LATDbits.LATD6 = 0;

    LATB = LATB & 0x80FF;

    while(1) {
        char c = getChar();
        if(c == 'a')
            LATB = (LATB & 0x80FF) | 0x0100;
        else if(c == 'b')
            LATB = (LATB & 0x80FF) | 0x0200;
        else if(c == 'c')
            LATB = (LATB & 0x80FF) | 0x0400;
        else if(c == 'd')
            LATB = (LATB & 0x80FF) | 0x0800;
        else if(c == 'e')
            LATB = (LATB & 0x80FF) | 0x1000;
        else if(c == 'f')
            LATB = (LATB & 0x80FF) | 0x2000;
        else if(c == 'g')
            LATB = (LATB & 0x80FF) | 0x4000;
    }
    return 0;
}
