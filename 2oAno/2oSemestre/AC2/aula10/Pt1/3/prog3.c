// configuraçao do UART - no datasheet procurar por pdsel (ultimo) - p 208

// exemplo para
// U2 19200 8,N,1
// U2BRG = 64;
// U2MODEbits.BRGH = 0;
// U2MODEbits.PDSEL = 0;
// U2MODEbits.STSEL = 0;
// U2STAbits.UTxEN = 1;
// U2STAbits.URxEN = 1;
// U2MODEbits.ON = 1;

// "O sinal à saída deste módulo é posteriormente dividido por 4 ou por 16, 
// em função da configuração do bit BRGH do registo UxMODE"
// se BRGH = 1, dividir por 4
// se BRGH = 0, dividir por 16

# include <detpic32.h>

void delay(unsigned int ms) {
    resetCoreTimer();
    while(readCoreTimer() < PBCLK/1000 * ms);
}

void putc(char byte) {
    while(U2STAbits.UTXBF == 1);
    U2TXREG = byte;
}

int main(void) {
    // Configure UART2: 
    // 1 - Configure BaudRate Generator
    U2BRG = 42;         // U2BRG = (20 * 10⁶6) / (4 * 115200) - 1     // arredondar para o inteiro mais proximo
    U2MODEbits.BRGH = 1;        // 16x baud clock enabled
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
        putc('+');
        delay(1000);
    }
    return 0;
}
