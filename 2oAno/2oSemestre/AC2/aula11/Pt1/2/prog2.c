#include <detpic32.h>

void putc(char byte2send) {
    // wait while UTxBF == 1;
    while(U2STAbits.UTXBF == 1);
    U2TXREG = byte2send;
}

void putStr (const char *str) {
    while (*str != '\0') {
        putc(*str);
        str++;
    }
}

int main(void) { 
    // Configure UART2: 115200, N, 8, 1 
    // Configure UART2: 
    // regra de polegar caso não digam: >= 115200 -> fato de div de baud x4
    // 1 - Configure BaudRate Generator 
    U2BRG = 42;           // U2BRG = (20 * 10⁶6) / (4 * 115200) - 1   = ~42,4
    // 2 – Configure number of data bits, parity and number of stop bits
    //     (see U2MODE register) 
    // (115200,N,8,1) -> 19200  bps,  sem paridade, 8 data bits, 1 stop bit
    U2MODEbits.BRGH = 1;        // 4x baud clock
    U2MODEbits.PDSEL = 0;       // no parity, 8-bit data
    U2MODEbits.STSEL = 0;       // 1 stop bit
    
    // 3 – Enable the trasmitter and receiver modules (see register U2STA) 
    U2STAbits.UTXEN = 1;        // enable transmitter module
    U2STAbits.URXEN = 1;        // enable receiver module

    // 4 – Enable UART2 (see register U2MODE) 
    U2MODEbits.ON = 1;

    // Configure UART2 interrupts, with RX interrupts enabled and TX interrupts disabled: 
    //    enable U2RXIE, disable U2TXIE (register IEC1)
    IEC1bits.U2RXIE = 1;
    IEC1bits.U2TXIE = 0;
        // set UART2 priority level (register IPC8)
            // ao contrario dos outros que seria ..  U2RXIF (exemplo), para a
            // priority flag, é apenas U2IP :)
    IPC8bits.U2IP = 2;
        // clear Interrupt Flag bit U2RXIF (register IFS1)
    IFS1bits.U2RXIF = 0;
        // define RX interrupt mode (URXISEL bits) 
    U2STAbits.URXISEL = 0;      // (vamos usar sempre este)

    // Enable global Interrupts 
    EnableInterrupts();

    while(1); 
    return 0; 
} 


void _int_(32) isr_u2(void) {
    unsigned char car = 0;

    if (IFS1bits.U2RXIF == 1) {
        // read char from FIFO (U2RXREG)
        car = U2RXREG;
        // send the char using putc()
        if (car == '?') {
            putStr("\nora boas pessoal daqui fala o feromonas e sejam bem vindos a mais um video da lenda de redstoneeeee");
        } else {
            putc(car);
        }
        // clear UART2 Rx interrupt flag 
        IFS1bits.U2RXIF = 0;
    }
}
