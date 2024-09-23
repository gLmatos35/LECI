# include <detpic32.h>

void putC(char byte2send) {
    while (U2STAbits.UTXBF == 1);
    U2TXREG = byte2send;
}

int main(void) {
    // uart2: 115200, N, 8, 1
    U2BRG = 42;
    U2MODEbits.BRGH = 1;

    U2MODEbits.PDSEL = 0;
    U2MODEbits.STSEL = 0;

    U2STAbits.UTXEN = 1;
    U2STAbits.URXEN = 1;

    U2MODEbits.ON = 1;      // ativar UART2

    // configurar interrupçoes da uart
    IEC1bits.U2RXIE = 1;        // receive interrupt enable
	IEC1bits.U2TXIE = 0;        // transmit interrupt enable

	IPC8bits.U2IP = 2;          // interrupt priority

	IFS1bits.U2RXIF = 0;        // reset receive interrupt flag
	U2STAbits.URXISEL = 0;      // receive interrupt mode selection bit -> 0
	
	EnableInterrupts();

    TRISCbits.TRISC14 = 0;      // output

    while(1);
    return 0;
}

void _int_(32) isr_uart2(void) {
    unsigned char car;

    if (IFS1bits.U2RXIF == 1) {
        car = U2RXREG;

        switch (car) {
            case 'T':
                LATCbits.LATC14 = 1;
                putC(car);
                break;
            case 't':
                LATCbits.LATC14 = 0;
                putC(car);
                break;
            default:
                putC(car);
                break;
        }
        IFS1bits.U2RXIF = 0;    // reset flag
    }
}
