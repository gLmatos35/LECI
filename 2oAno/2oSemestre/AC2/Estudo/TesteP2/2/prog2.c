# include <detpic32.h>

int main(void) {
    TRISBbits.TRISBx = 1;       // RBx configured as analog input
    AD1PCFGbits.PCFGx= 0;       // Conversion trigger selection bits: in this
    AD1CON1bits.SSRC = 7;       // mode an internal counter ends sampling and starts converison
    
    AD1CON1bits.CLRASAM = 1; // Stop conversions when the 1st A/D converter
    // interrupt is generated. At the same time,
    // hardware clears the ASAM bit
    AD1CON3bits.SAMC = 16;
    // Sample time is 16 TAD (TAD = 100 ns)
    AD1CON2bits.SMPI = N-1; // Interrupt is generated after N samples
    // (replace N by the desired number of
    // consecutive samples)
    AD1CHSbits.CH0SA = x;
    // replace x by the desired input
    // analog channel (0 to 15)
    AD1CON1bits.ON = 1;
    // Enable A/D converter
    // This must the last command of the A/D
    // configuration sequence

    return 0;
}