        .equ putChar,3
        .equ printInt,6
        .equ readCoreTimer,11
        .equ resetCoreTimer,12
        
        .data

        .text
        .globl main
main:   addiu $sp,$sp,-4
        sw $s0,0($sp)

        li $s0,0                # counter = 0;

while:  li $a0,'\r'
        li $v0,putChar
        syscall                 # putChar('\r');

        move $a0,$s0            # counter
        li $a1,10
        li $t0,4
        sll $t0,$t0,16
        or $a1,$a1,$t0          # 10 | 4 << 16
        li $v0,printInt
        syscall                 # printInt(counter, 10 | 4 << 16);

        jal delay
        
        addi $s0,$s0,1          # counter++;

        j while

        li $v0,0                # return 0;

        lw $s0,0($sp)
        addiu $sp,$sp,4

        jr $ra


####
# void delay(unsigned int ms) 
# { 
#       resetCoreTimer(); 
#       while(readCoreTimer() < K * ms); 
# }
# para atrasos de 1ms, K = 20 000 (alegadamente)

        .text
delay:  move $t0,$a0            # int ms;

        li $v0,resetCoreTimer
        syscall                 # resetCoreTimer();

whileD: li $v0,readCoreTimer
        syscall
        move $t1,$v0            # readCoreTimer();

        bge $t1,20000,endwd
        j whileD

endwd:  
        jr $ra
