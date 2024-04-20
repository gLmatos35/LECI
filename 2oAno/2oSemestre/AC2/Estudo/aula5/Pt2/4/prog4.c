# include <detpic32.h>

unsigned char toBcd(unsigned char value) {
    return ((value / 10) << 4) + (value % 10);
}


void send2displays(unsigned char value) {
    unsigned int dl, dh;
    
    static char displayFlag = 0;

    static int display7Scodes[10] = {0x3F, 0x06, 0x5b, 0x4F, 0x66, 0x6D, 0x7D,
0x07, 0x7F, 0x6F};        // 0 to 9

    value = toBcd(value);

    dl = (value & 0x0F);
    dh = (value >> 4);

    if (displayFlag == 0) {
        LATD = (LATD & 0xFF9F) | 0x0020;
        LATB = (LATB & 0x80FF) | display7Scodes[dl] << 8;
    } else {
        LATD = (LATD & 0xFF9F) | 0x0040;
        LATB = (LATB & 0x80FF) | display7Scodes[dh] << 8;
    }

    displayFlag = !displayFlag;
}


void delay(unsigned int ms) {
    resetCoreTimer();
    while(readCoreTimer() < (PBCLK / 1000) * ms);
}


int main() {
    int i = 0;
    int counter = 0;
    unsigned char switch0;
    unsigned int pila = 0;


    TRISD = (TRISD & 0xFF9F);       // config as outputs
    TRISB = (TRISB & 0x80FF);       // config as outputs

    TRISE = (TRISE & 0xFF00);       // config as outputs

    TRISB = (TRISB | 0x000F);       // config as inputs (switches)

    TRISC = (TRISC & 0xBFFF);       // config led C14 as output;

    LATCbits.LATC14 = '0';          // turn led c14 off

    while(1) {
        delay(10);

        send2displays(counter);

        LATE = (LATE & 0xFF00) | counter;

        switch0 = (PORTB & 0x000F);

        // if (i % 50 == 0) {
        //     if (switch0 == 1) {
        //         counter = (counter + 1) % 60;
        //     } else {
        //         counter = (counter + 59) % 60;
        //     }
        // }

        if ((i%20 == 0) & (switch0 == 1)) {
            counter = (counter + 1) % 60;
            if (counter == 59) {
                pila = 500;
            }
        }
        if ((i%50 == 0) & (switch0 == 0)) {
            counter = (counter + 59) % 60;
            if (counter == 0) {
                pila = 500;                 // 5s / 10ms
            }
        }

        if (pila > 0) {
            LATCbits.LATC14 = '1';
            pila--;
        } else {
            LATCbits.LATC14 = '0';
        }
        
        // if (pila > 0) {
        //     lede acende
        //     pila--
        // } else {
        //     apaga
        // }
        // if counter == 59 ou 00
        //     pila = 500

        i++;
    }

    return 0;
}
