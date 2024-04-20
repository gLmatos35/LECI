        .equ inkey,1
        .equ putChar,3
        .equ printInt,6

        .data

        .text
        .globl main
main:   li $t0,0                # cnt = 0;
do:     li $v0,inkey
        syscall
        move $t1,$v0            # c = inkey();

if:     beq $t1,0x0000,else          # if (c != 0)
        move $a0,$t1
        li $v0,putChar
        syscall                 # putChar(c);
        j endif

else:   li $a0,'.'
        li $v0,putChar
        syscall                 # putChar('.');

endif:

        addi $t0,$t0,1          # cnt++

while:  bne $t1,'\n',do         # while (c != '\n');
        
        move $a0,$t0
        li $a1,10
        li $v0,printInt
        syscall                 # printInt(cnt,10);
        
        li $v0,0                # return 0;

        jr $ra