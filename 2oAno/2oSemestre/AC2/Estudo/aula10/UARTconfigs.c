// regra de polegar caso não digam: >= 115200 -> fato de div de baud x4

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


void putC(char byte2send) {
    // wait while UTXBF == 1
    while(U2STAbits.UTXBF == 1);
    // copy byte2send to the UxTXREG register
    U2TXREG = byte2send;
}

char getC(void) {
    // if OERR == 1 then reset OERR
    if(U2STAbits.OERR == 1) {U2STAbits.OERR == 0;}
    // wait while URXDA == 0
    while(U2STAbits.URXDA == 0);
    // return UxRXREG
    return U2RXREG;
}


Utilização ERRADA:                              Utilização correta: 
if(U2RXREG == 'x')                              char c;
    ...                                           c = U2RXREG;
else if(U2RXREG == 'y')                         if(c == 'x')
    ...                                             ...
                                                else if(c == 'y')
                                                    ...