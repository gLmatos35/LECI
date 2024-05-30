# include <detpic32.h>

void putc(char byte2send) {
    // wait while UTxBF == 1;
    while(U2STAbits.UTXBF == 1);
    U2TXREG = byte2send;
}

void putstr (const char *str) {
    while (*str != '\0') {
        putc(*str);
        str++;
    }
}

int main(void) {
    // Configure UART2: 
    // 1 - Configure BaudRate Generator
    U2BRG = 10;         // U2BRG = (20 * 10⁶6) / (16 * 115200) - 1      // arredondar para o inteiro mais proximo
    U2MODEbits.BRGH = 0;        // 16x baud clock enabled
    // 2 – Configure number of data bits, parity and number of stop bits
    U2MODEbits.PDSEL = 0;       // 8-bit data no parity
    U2MODEbits.STSEL = 0;
    //     (see U2MODE register) 
    // 3 – Enable the trasmitter and receiver modules (see register U2STA) 
    U2STAbits.UTXEN = 1;
    U2STAbits.URXEN = 1;
    // 4 – Enable UART2 (see register U2MODE)    
    U2MODEbits.ON = 1;

    while(1) {
        putstr("String de teste\n");
        resetCoreTimer();
        while(readCoreTimer() < 20000000);      // wait 1 sec
    }

    return 0;
}
