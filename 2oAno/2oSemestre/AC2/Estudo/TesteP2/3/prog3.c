# include <detpic32.h>

unsigned char toBcd(unsigned char value) {
    return ((value / 10) << 4) + (value % 10);
}

void putc(char byte2send) {
    while (U2STAbits.UTXBF == 1);
    U2TXREG = byte2send;
}

void putstr(char *str) {
    while(*str) {
        putc(*str++);
    }
}

int main(void) {
    // led
    TRISEbits.TRISE7 = 0;       // output
    LATEbits.LATE7 = 0;         // valor inicial
    
    // 0000 0000 0000 1111
    TRISB = (TRISB | 0x000F);

    // 9600,O,8,2
    U2BRG = 129;
    U2MODEbits.BRGH = 0;        // x16

    U2MODEbits.PDSEL = 2;       // 8 bits, odd parity
    U2MODEbits.STSEL = 1;       // 2 stop bits

    U2STAbits.UTXEN = 1;        // transmit enable
    U2STAbits.URXEN = 1;        // receive enable

    U2MODEbits.ON = 1;          // enable

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
    if(IFS1bits.U2RXIF == 1) {
        car = U2RXREG;
        putc(car);

        value = (PORTB & 0x000F);

        if(car == 'D') {
            putc('\n');
            putstr("DSD=");
            // putc(value);
			unsigned char bcdValue = toBcd(value);
			// putc((bcdValue >> 4) + '0'); // Send tens digit
			// putc((bcdValue & 0x0F) + '0'); // Send units digit 
            putc(PORTBbits.RB3 + '0');          
            putc(PORTBbits.RB2 + '0');          
            putc(PORTBbits.RB1 + '0');          
            putc(PORTBbits.RB0 + '0');          
        }
        putc('\n');
        LATEbits.LATE7 = !LATEbits.LATE7;
    }
    IFS1bits.U2RXIF = 0;
}

