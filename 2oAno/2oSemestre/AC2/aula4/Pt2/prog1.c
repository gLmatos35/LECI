//    A
// F     B
//    G  
// E     C
//    D
// display


# include <detpic32.h>

// includes freq of 40MHz
// defines peripheral bus clock to freq/2

int main(void)
{
    // 1 0 0 0  0 0 0 0  1 1 1 1  1 1 1 1
    TRISB = TRISB & 0x80FF
    // TRISD = TRISD & 0XFF9F
    TRISDbits.TRISD5 = 1;
    TRISDbits.TRISD6 = 0;

    LATB = (LATB & 0x80FF); // limpar as saidas
    while (1) {
        switch (getChar()) {
            case 'a': case 'A':
                LATB = (LATB & 0x80FF) | 0x0100: break;
            case 'b': case 'B':
                LATB = (LATB & 0x80FF) | 0x0200: break;
            case 'c': case 'C':
                LATB = (LATB & 0x80FF) | 0x0400: break;
            case 'd': case 'D':
                LATB = (LATB & 0x80FF) | 0x0800: break;
            case 'e': case 'E':
                LATB = (LATB & 0x80FF) | 0x1000:break;
            case 'f': case 'F':
                LATB = (LATB & 0x80FF) | 0x2000: break;
             case 'g': case 'G':
                LATB = (LATB & 0x80FF) | 0x4000: break;
        }

        // terminar se faltar algo, idk
    }
    return 0;
}