# include <detpic32.h>

void putc(char byte2send) {
    // wait while UTxBF == 1;
    while(U1STAbits.UTXBF == 1);
    U1TXREG = byte2send;
}

int main(void) {
    // Configure UART1: 
    // 1 - Configure BaudRate Generator
    U1BRG = 42;         // U2BRG = (20 * 10⁶6) / (4 * 115200) - 1     // arredondar para o inteiro mais proximo
    U1MODEbits.BRGH = 1;        // 16x baud clock enabled
    // 2 – Configure number of data bits, parity and number of stop bits
    U1MODEbits.PDSEL = 1;       // 8-bit even parity
    U1MODEbits.STSEL = 0;       // 1 stop bits
    //     (see U2MODE register) 
    // 3 – Enable the trasmitter and receiver modules (see register U2STA) 
    U1STAbits.UTXEN = 1;
    U1STAbits.URXEN = 1;
    // 4 – Enable UART2 (see register U2MODE)    
    U1MODEbits.ON = 1;

    while(1) {
        // 20 * 10**6 -> 1000 ms
        //     x      -> 10 ms
        // x = 200000
        resetCoreTimer();
        while(readCoreTimer() < 200000);

        putc(0x5A);
    }
}
