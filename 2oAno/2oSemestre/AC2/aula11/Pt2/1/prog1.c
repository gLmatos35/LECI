# include <detpic32.h>

typedef struct { 
    char mem[100]; // Storage area 
    int nchar;   // Number of characters to be transmitted 
    int posrd;   // Position of the next character to be transmitted 
} t_buf; 

volatile t_buf txbuf;

void putStrInt(char *s) {
    while(txbuf.nchar > 0);         // wait while the buffer is not empty
    // Copy all characters of the string "s" to the buffer, and update "nchar"
    while(*s != '\0') {
        txbuf.mem(txbuf.nchar) = *s;
        s++;
        txbuf.nchar++;
    }
    // Initialize "posrd" variable with 0 
    txbuf.posrd = 0;
    // Enable UART2 Tx interrupts 
    IEC1bits.U2TXIE = 1;
}

void _int_(32) isr_uart2(void) { 
    if (IFS1bits.U2TXIF == 1) { 
        if(txbuf.nchar > 0) { // At least one character to be transmitted 
        // U2TXREG = ... // Read 1 character from the buffer and send it

        // Update buffer "posrd" and "nchar" variables 
        } else { 
        // Disable UART2 Tx interrupts 
        // foda se heheheheheeh (foto conseguida sou fixe  )
        
        } 
        // Clear UART2 Tx interrupt flag 
    } 
}

int main(void) {

}


void 