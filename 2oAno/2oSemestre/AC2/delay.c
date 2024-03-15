void delay(unsigned int ms)
{
    resetCoreTimer();
    while(readCoreTimer() < K * ms);
}

// K = PBCLK/1000