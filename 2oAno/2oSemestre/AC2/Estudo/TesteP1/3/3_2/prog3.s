        .equ baseAddress,0xBF88
        .equ TRISE,0x6100
        .equ PORTE,0x6110
        .equ LATE,0x6120

        .equ readCoreTimer,11
	.equ resetCoreTimer,12

        .equ putChar,3
        .equ printInt,6

        .data
        .text
        .globl main
main:   lui $t0,baseAddress
        lw $t1,TRISE($t0)
        andi $t1,$t1,0xFFC1
        sw $t1,TRISE($t0)                       # re5 to re1 as outputs

        li $s0,0x2                              # bit inicial
while:  move $a0,$s0
        srl $a0,$a0,1
        li $a1,2
        li $t3,5
        sll $t3,$t3,16
        or $a1,$a1,$t3
        li $v0,printInt
        syscall

        lw $t1,LATE($t0)
        andi $t1,$t1,0xFFC1
        or $t1,$t1,$s0
        sw $t1,LATE($t0)       

        li $a0,'\r'
        li $v0,putChar
        syscall

        sll $s0,$s0,1
if:     bne $s0,0x40,skip
        li $s0,0x2                              # restart sequence
skip:

        li $v0,resetCoreTimer
        syscall

loop:   li $v0,readCoreTimer
        syscall
        blt $v0,8695652,loop

        j while

        li $v0,0                                # return 0;
        jr $ra
