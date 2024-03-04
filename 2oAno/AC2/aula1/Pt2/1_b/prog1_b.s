        .equ inkey,1
        .equ putChar,3
        .equ printInt,6

        .data

        .text
        .globl main
main:   addiu $sp,$sp,-12
        sw $ra,0($sp)
        sw $s0,4($sp)
        sw $s1,8($sp)

        li $s0,0                # cnt = 0;
do:     li $v0,inkey
        syscall                 # c = inkey();
        move $s1,$v0
        
if:     beq $v0,'0',else
        move $a0,$v0
        li $v0,putChar
        syscall                 # putChar(c);
        j endif

else:   li $a0,'.'
        li $v0,putChar
        syscall                 # putChar('.');

endif:  addi $s0,$s0,1          # cnt++;
while:  bne $s1,'\n',do         # while (c != '\n');

        move $a0,$s0
        li $a1,10
        li $v0,printInt
        syscall                 # printInt(cnt,10);

        li $v0,0                # return 0;

        lw $ra,0($sp)
        lw $s0,4($sp)
        lw $s1,8($sp)
        addiu $sp,$sp,12
        jr $ra
