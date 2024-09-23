# include <detpic32.h>

unsigned char toBcd(unsigned char value) {
    return ((value / 10) << 4) + (value % 10);
}

void putc(char byte2send) {
    // wait while UTXBF == 1
    while(U2STAbits.UTXBF == 1);
    // Copy byte2send to the UxTXREG register
    U2TXREG = byte2send;
}

void putstr(char *str) {
    while(*str != '\0') {
        putc(*str++);
    }
}

int main(void) {
    // LED
    TRISEbits.TRISE7 = 0;       // output
    LATEbits.LATE7 = 0;         // valor inicial = 0

    // SWITCHES
    TRISB = TRISB | 0x000F;     // input

    // 9600,O,8,2
    U2BRG = 129;
    U2MODEbits.BRGH = 0;        // x16

    U2MODEbits.PDSEL = 2;
    U2MODEbits.STSEL = 1;

    U2STAbits.UTXEN = 1;
    U2STAbits.URXEN = 1;

    U2MODEbits.ON = 1;

    // configurar interrupçoes da uart
    IEC1bits.U2RXIE = 1;        // receive interrupt enable
	IEC1bits.U2TXIE = 0;        // transmit interrupt enable

	IPC8bits.U2IP = 2;          // interrupt priority

	IFS1bits.U2RXIF = 0;        // reset receive interrupt flag
	U2STAbits.URXISEL = 0;      // receive interrupt mode selection bit -> 0

    EnableInterrupts();

    while(1);
    return 0;
}

void _int_(32) isr_uart2(void) {
    unsigned char car;
    unsigned char value;

    if (IFS1bits.U2RXIF == 1) {     // interrupçao de receçao ativada
        car = U2RXREG;
        putc(car);

        value = PORTB & 0x000F;      // ultimos 4 bits - corresponde as switches
        value = toBcd(value);

        if(car == 'D') {
            putc('\n');
            putstr("DSD=");
            putc((value >> 4) + '0');
            putc((value & 0x0F) + '0');
        }
        putc('\n');
        LATEbits.LATE7 = !LATEbits.LATE7;   // mudar sempre que recebe caracter
    }
    IFS1bits.U2RXIF = 0;
}
