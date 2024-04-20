void delay(unsigned int ms)
{
    resetCoreTimer();
    while(readCoreTimer() < K * ms);
}

// K = PBCLK/1000



// assembly
        .text
delay:  move $t0,$a0            # int ms;

        li $v0,resetCoreTimer
        syscall                 # resetCoreTimer();

whileD: li $v0,readCoreTimer
        syscall
        move $t1,$v0            # readCoreTimer();

        mul $t2,$t0,20000       # int ms * 20000

        bge $t1,$t2,endwd
        j whileD

endwd:  
        jr $ra