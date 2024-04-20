        .equ getChar,2
        .equ putChar,3
        .equ printInt,6

        .data

        .text
        .globl main
main:   li $t0,0                # cnt = 0;
do:     li $v0,getChar
        syscall
        move $t1,$v0            # c = getChar();
        move $a0,$t1
        
        # addi $a0,$a0,1          # so that c is now c+1;;

        li $v0,putChar
        syscall                 # putChar(c);

        addi $t0,$t0,1          # cnt++

while:  bne $t1,'\n',do         # while (c != '\n');
        
        move $a0,$t0
        li $a1,10
        li $v0,printInt
        syscall                 # printInt(cnt,10);
        
        li $v0,0                # return 0;

        jr $ra