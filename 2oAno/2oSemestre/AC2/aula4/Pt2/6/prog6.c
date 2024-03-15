# include <detpic32.h>
    
    static int display7Scodes[16] = {0x3F, 0x06, 0x5b, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F, 0x77,0x7C,0x39, 0x5E,0x79,0x71};


int main(void) {

    unsigned int side, hexDigit;

    TRISB = TRISB | 0x000F;     // 0000 0000 0000 1111
    // configure ports RB8 to RB14 as outputs
    TRISB = TRISB & 0x80FF;     // 1000 0000 1111 1111
    // configure ports RD5 to RD6 as outputs
    TRISD = TRISD & 0xFF9F;     // 1111 1111 1001 1111

    side = 1;       // choose dislay side
    // main loop
    while (inkey() != 'q') {
        hexDigit = PORTB & 0x000F;
        // display
        if(side == 0)
            LATD = (LATD & 0xFF9F) | 0x0020;    // bit5

        else
            LATD = (LATD & 0xFF9F) | 0x0040;    // bit6

        LATB = (LATB & 0x80FF) | (display7Scodes[hexDigit] << 8);
    }
    return 0;
}