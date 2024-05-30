        .equ baseAddress,0xBF88
        .equ TRISE,0x6100
        .equ PORTE,0x6110
        .equ LATE,0x6120

        .equ readCoreTimer,11
	.equ resetCoreTimer,12

        .data
        .text
        .globl main
main:   addiu $sp,$sp,-4
        sw $s0,0($sp)

        lui $t0,baseAddress
        lw $t1,TRISE($t0)
        andi $t1,$t1,0xFFC1
        sw $t1,TRISE($t0)                       # re5 to re1 as outputs

        li $s0,0x2                              # bit inicial

while:  
        li $v0,resetCoreTimer
        syscall

loop:   li $v0,readCoreTimer
        syscall
        blt $v0,8695652,loop


        lw $t1,LATE($t0)
        andi $t1,$t1,0xFFC1
        or $t1,$t1,$s0
        sw $t1,LATE($t0)                

        sll $s0,$s0,1
if:     bne $s0,0x40,skip
        li $s0,0x2                              # restart sequence
skip:

        j while

        lw $s0,0($sp)
        addiu $sp,$sp,4

        li $v0,0                                # return 0;

        jr $ra
