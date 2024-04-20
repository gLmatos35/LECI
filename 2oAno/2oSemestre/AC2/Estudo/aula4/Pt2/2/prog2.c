# include <detpic32.h>

int main(void) { 
    int i;

    unsigned char segment; 
    // enable display low (RD5) and disable display high (RD6) 
    LATDbits.LATD5 = 1;
    LATDbits.LATD6 = 0;
    // configure RB8-RB14 as outputs 
    TRISB = TRISB & 0x80FF;
    // configure RD5-RD6 as outputs 
        TRISD = TRISD & 0xFF9F;

    while(1) 
    { 
    segment = 1; 
    for(i=0; i < 7; i++) 
    { 
        // send "segment" value to display 
        if(i == 1)
            LATB = (LATB & 0x80FF) | 0x0100;
        else if(i == 2)
            LATB = (LATB & 0x80FF) | 0x0200;
        else if(i == 3)
            LATB = (LATB & 0x80FF) | 0x0400;
        else if(i == 4)
            LATB = (LATB & 0x80FF) | 0x0800;
        else if(i == 5)
            LATB = (LATB & 0x80FF) | 0x1000;
        else if(i == 6)
            LATB = (LATB & 0x80FF) | 0x2000;
        else if(i == 7)
            LATB = (LATB & 0x80FF) | 0x4000;
        // wait 0.5 second 
        resetCoreTimer();
        while(readCoreTimer() < PBCLK/2);

        segment = segment << 1; 
    } 
    // toggle display selection 
    LATDbits.LATD5 = !LATDbits.LATD5;
    LATDbits.LATD6 = !LATDbits.LATD6;
    } 
    return 0; 
}
