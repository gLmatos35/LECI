# include <detpic32.h>

void putC(char byte2send) {
    // wait while UTXBF == 1
    while(U2STAbits.UTXBF == 1);
    // copy byte2send to the UxTXREG register
    U2TXREG = byte2send;
}

void delay(unsigned int ms) {
    resetCoreTimer();
    while(readCoreTimer() < PBCLK/1000 * ms);
}

char getC(void) {
    // if OERR == 1 then reset OERR
    if(U2STAbits.OERR == 1) {U2STAbits.OERR == 0;}
    // wait while URXDA == 0
    while(U2STAbits.URXDA == 0);
    // return UxRXREG
    return U2RXREG;
}

int main(void) {
    unsigned char car;
    // Configure UART2: (115200,N,8,1)
    // 1 - Configure BaudRate Generator 
    U2BRG = 42;                 // UxBRG = (20*10^6)
    U2MODEbits.BRGH = 1;        // fator de divisao de 4
    // 2 – Configure number of data bits, parity and number of stop bits 
    //     (see U2MODE register) 
    U2MODEbits.PDSEL = 0;       // 8 bit data, no parity
    U2MODEbits.STSEL = 0;       // 1 stop bit    
    // 3 – Enable the trasmitter and receiver modules (see register U2STA) 
    U2STAbits.UTXEN = 1;        // transmitter enable
    U2STAbits.URXEN = 1;        // receiver enable
    // 4 – Enable UART2 (see register U2MODE)
    U2MODEbits.ON = 1;

    while(1) {
        car = getC();
        putC(car);
    }
    return 0;
}
